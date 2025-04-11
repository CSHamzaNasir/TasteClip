import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:timeago/timeago.dart' as timeago;

class WatchFeedbackController extends GetxController {
  var feedbackList = <Map<String, dynamic>>[].obs;
  var feedbackListText = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var selectedTopFilter = 0.obs;
  var feedback = {}.obs;
  var currentScope = FeedbackScope.allFeedback.obs;

  @override
  void onInit() {
    super.onInit();
    fetchImageFeedback();
    fetchFeedbackText();
  }

  String get currentUserId => FirebaseAuth.instance.currentUser?.uid ?? '';

  Future<void> likeFeedback(String feedbackId) async {
    try {
      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc(feedbackId);

      await feedbackDoc.update({
        'likes.$currentUserId': true,
      });

      log("Feedback liked by user: $currentUserId");
    } catch (e) {
      log("Error liking feedback: $e");
      Get.snackbar("Error", "Failed to like feedback: $e");
    }
  }

  Future<void> unlikeFeedback(String feedbackId) async {
    try {
      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc(feedbackId);

      await feedbackDoc.update({
        'likes.$currentUserId': FieldValue.delete(),
      });

      log("Feedback unliked by user: $currentUserId");
    } catch (e) {
      log("Error unliking feedback: $e");
      Get.snackbar("Error", "Failed to unlike feedback: $e");
    }
  }

  bool hasUserLikedFeedback(Map<String, dynamic> feedback) {
    final likes = feedback['likes'];
    if (likes is Map<dynamic, dynamic>) {
      return likes.containsKey(currentUserId);
    }
    return false;
  }

  Future<void> toggleLikeFeedback(
      String feedbackId, Map<String, dynamic> feedback) async {
    if (hasUserLikedFeedback(feedback)) {
      await unlikeFeedback(feedbackId);
    } else {
      await likeFeedback(feedbackId);
    }

    fetchFeedbackText();
  }

  Future<void> fetchFeedbackText({String? branchName}) async {
    try {
      String selectedMealType = filters[selectedTopFilter.value];

      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedbackText = [];

      for (var doc in feedbackQuery.docs) {
        Map<String, dynamic> feedbackData = doc.data() as Map<String, dynamic>;

        if (feedbackData['category'] == "text_feedback" &&
            (selectedMealType == "All" ||
                feedbackData['mealType'] == selectedMealType) &&
            (branchName == null || feedbackData['branchName'] == branchName)) {
          DateTime createdAt = feedbackData['createdAt'].toDate();

          DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
              .collection('email_user')
              .doc(feedbackData['userId'])
              .get();

          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;

          Map<String, dynamic> feedbackWithUser = {
            "feedbackId": feedbackData['feedbackId'],
            "branch": feedbackData['branchName'],
            "branchThumbnail": feedbackData['branchThumbnail'],
            "review": feedbackData['review'],
            "rating": feedbackData['rating'].toString(),
            "created_at": timeago.format(createdAt),
            "meal_type": feedbackData['mealType'],
            "user_id": feedbackData['userId'],
            "user_fullName": userData['fullName'],
            "user_profileImage": userData['profileImage'],
            "likes": feedbackData['likes'] ?? {},
          };

          allFeedbackText.add(feedbackWithUser);
        }
      }

      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch text feedback: $e");
    }
  }

  final List<String> categories = ["Text", "Image", "Videos"];
  final List<String> filters = ["All", "Breakfast", "Lunch", "Dinner"];

  void changeCategory(int index) {
    selectedIndex.value = index;
    if (categories[index] == "Text") {
      fetchFeedbackText();
    }
    if (categories[index] == "Image") {
      fetchImageFeedback();
    }
    log('Selected Category: ${categories[index]}');
  }

  void changeFilter(int index) {
    selectedTopFilter.value = index;
    fetchImageFeedback();
    fetchFeedbackText();
  }

  Future<void> fetchImageFeedback() async {
    try {
      log('--- STARTING IMAGE FEEDBACK FETCH ---');
      log('Current Scope: ${currentScope.value}');
      log('Current User ID: $currentUserId');
      log('Selected Meal Type: ${filters[selectedTopFilter.value]}');

      // Base query
      Query query = FirebaseFirestore.instance
          .collection('feedback')
          .where('category', isEqualTo: 'image_feedback')
          .orderBy('createdAt', descending: true);

      // Apply scope filter
      if (currentScope.value == FeedbackScope.currentUserFeedback) {
        log('Applying current user filter...');
        query = query.where('userId', isEqualTo: currentUserId);
      } else {
        log('Showing all feedback (no user filter)');
      }

      // Apply meal type filter
      if (filters[selectedTopFilter.value] != "All") {
        log('Applying meal type filter: ${filters[selectedTopFilter.value]}');
        query = query.where('mealType',
            isEqualTo: filters[selectedTopFilter.value]);
      }

      log('Executing Firestore query...');
      QuerySnapshot feedbackQuery = await query.get();
      log('Received ${feedbackQuery.docs.length} documents from Firestore');

      List<Map<String, dynamic>> allFeedback = [];

      for (var doc in feedbackQuery.docs) {
        Map<String, dynamic> feedbackData = doc.data() as Map<String, dynamic>;
        log('\nProcessing document ID: ${doc.id}');
        log('Feedback data: $feedbackData');

        // Verify user match for current user scope
        if (currentScope.value == FeedbackScope.currentUserFeedback) {
          log('Checking user match:');
          log('Document userId: ${feedbackData['userId']}');
          log('Current userId: $currentUserId');
          if (feedbackData['userId'] != currentUserId) {
            log('⚠️ USER MISMATCH - SKIPPING THIS DOCUMENT');
            continue;
          }
        }

        DateTime createdAt = feedbackData['createdAt'].toDate();
        log('Created at: $createdAt');

        // Fetch user data
        log('Fetching user data for userId: ${feedbackData['userId']}');
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('email_user')
            .doc(feedbackData['userId'])
            .get();

        if (userSnapshot.exists) {
          Map<String, dynamic> userData =
              userSnapshot.data() as Map<String, dynamic>;
          log('User data: $userData');

          final feedbackItem = {
            "feedbackId": doc.id,
            "branch": feedbackData['branchName'] ?? '',
            "restaurantName": feedbackData['restaurantName'] ?? '',
            "branchThumbnail": feedbackData['branchThumbnail'] ?? '',
            "image_title": feedbackData['imageTitle'] ?? '',
            "description": feedbackData['description'] ?? '',
            "imageUrl": feedbackData['imageUrl'] ?? '',
            "rating": feedbackData['rating']?.toString() ?? '0',
            "created_at": timeago.format(createdAt),
            "meal_type": feedbackData['mealType'] ?? '',
            "user_id": feedbackData['userId'] ?? '',
            "user_fullName": userData['fullName'] ?? 'Unknown User',
            "user_profileImage": userData['profileImage'] ?? '',
            "likes": feedbackData['likes'] ?? {},
            "isCurrentUser": feedbackData['userId'] ==
                currentUserId, // Add flag for current user
          };

          log('Constructed feedback item: $feedbackItem');
          allFeedback.add(feedbackItem);

          // Add icon indicator in logs
          if (feedbackItem['isCurrentUser']) {
            log('👤 THIS IS CURRENT USER\'S FEEDBACK');
          } else {
            log('👥 OTHER USER\'S FEEDBACK');
          }
        } else {
          log('⚠️ User document not found for userId: ${feedbackData['userId']}');
        }
      }

      log('\nTOTAL FILTERED FEEDBACK: ${allFeedback.length} items');
      log('FEEDBACK LIST CONTENT:');
      for (var item in allFeedback) {
        log('• ${item['user_fullName']} - ${item['isCurrentUser'] ? "YOUR CONTENT" : "Other"} - ${item['image_title']}');
      }

      feedbackList.assignAll(allFeedback);
      log('--- FEEDBACK FETCH COMPLETE ---\n');
    } catch (e) {
      log('❌ ERROR IN fetchImageFeedback: $e');
      feedbackList.clear();
      Get.snackbar("Error", "Failed to fetch image feedback");
    }
  }

  void changeScope(FeedbackScope scope) {
    currentScope.value = scope;
    fetchImageFeedback();
  }

  Future<void> addCommentToFeedback({
    required String feedbackId,
    required String commentText,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        return;
      }

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc(feedbackId);

      await feedbackDoc.update({
        'comments': FieldValue.arrayUnion([
          {
            'userId': user.uid,
            'commentText': commentText,
            'timestamp': DateTime.now(),
          }
        ]),
      });

      log("Comment added successfully!");
    } catch (e) {
      log("Error adding comment: $e");
    }
  }

  Future<Map<String, dynamic>> fetchFeedback(String feedbackId) async {
    try {
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .get();

      if (feedbackDoc.exists) {
        return feedbackDoc.data() as Map<String, dynamic>;
      } else {
        log("Feedback not found!");
        return {};
      }
    } catch (e) {
      log("Error fetching feedback: $e");
      return {};
    }
  }
}
