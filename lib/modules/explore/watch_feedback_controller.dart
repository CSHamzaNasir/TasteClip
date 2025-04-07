import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:timeago/timeago.dart' as timeago;

class WatchFeedbackController extends GetxController {
  var feedbackList = <Map<String, dynamic>>[].obs;
  var feedbackListText = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var selectedTopFilter = 0.obs;
  var feedback = {}.obs;

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

  @override
  void onInit() {
    super.onInit();
    fetchImageFeedback();
    fetchFeedbackText();
  }

  Future<void> fetchImageFeedback() async {
    try {
      String selectedMealType = filters[selectedTopFilter.value];

      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedback = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) =>
              feedbackData['category'] == "image_feedback" &&
              (selectedMealType == "All" ||
                  feedbackData['mealType'] == selectedMealType))
          .map((feedbackData) {
        DateTime createdAt = feedbackData['createdAt'].toDate();
        return {
          "feedbackId": feedbackData['feedbackId'],
          "branch": feedbackData['branchName'],
          "restaurantName": feedbackData['restaurantName'],
          "branchThumbnail": feedbackData['branchThumbnail'],
          "image_title": feedbackData['imageTitle'],
          "description": feedbackData['description'],
          "imageUrl": feedbackData['imageUrl'],
          "rating": feedbackData['rating'].toString(),
          "created_at": timeago.format(createdAt),
          "meal_type": feedbackData['mealType'],
        };
      }).toList();

      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch image feedback: $e");
    }
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
