import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:timeago/timeago.dart' as timeago;

class ImageFeedbackController extends GetxController {
  final UserRole role;
  ImageFeedbackController({required this.role});

  var feedbackList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchImageFeedback();
  }

  Future<void> fetchImageFeedback() async {
    try {
      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedback = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) =>
              feedbackData['category'] ==
              "image_feedback")  
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
}

  // Future<void> fetchImageFeedback() async {
  //   try {
  //     QuerySnapshot restaurantQuery =
  //         await FirebaseFirestore.instance.collection('restaurants').get();
  //     QuerySnapshot userQuery =
  //         await FirebaseFirestore.instance.collection('email_user').get();

  //     // Store user details including profile image
  //     Map<String, Map<String, String>> userMap = {};
  //     for (var userDoc in userQuery.docs) {
  //       userMap[userDoc['uid']] = {
  //         "fullName": userDoc['fullName'] ?? "Unknown User",
  //       };
  //     }

  //     List<Map<String, dynamic>> allFeedback = [];
  //     String? currentUserBranchId;
  //     String currentUserId = FirebaseAuth.instance.currentUser!.uid;

  //     if (role == UserRole.manager) {
  //       for (var restaurantDoc in restaurantQuery.docs) {
  //         List<dynamic> branches = restaurantDoc['branches'] ?? [];
  //         for (var branch in branches) {
  //           if (branch['branchId'] == currentUserId) {
  //             currentUserBranchId = branch['branchId'];
  //             break;
  //           }
  //         }
  //         if (currentUserBranchId != null) break;
  //       }
  //     }

  //     for (var restaurantDoc in restaurantQuery.docs) {
  //       List<dynamic> branches = restaurantDoc['branches'] ?? [];
  //       for (var branch in branches) {
  //         List<dynamic> feedbacks = branch['imageFeedback'] ?? [];
  //         for (var feedback in feedbacks) {
  //           String userId = feedback['user_id'] ?? '';
  //           String userName = userMap[userId]?["fullName"] ?? "Unknown User";

  //           if (role == UserRole.user && feedback['user_id'] != currentUserId) {
  //             continue;
  //           }

  //           if (role == UserRole.manager &&
  //               branch['branchId'] != currentUserBranchId) {
  //             continue;
  //           }

  //           DateTime createdAt;
  //           if (feedback['created_at'] is Timestamp) {
  //             createdAt = (feedback['created_at'] as Timestamp).toDate();
  //           } else if (feedback['created_at'] is String) {
  //             createdAt =
  //                 DateTime.tryParse(feedback['created_at']) ?? DateTime.now();
  //           } else {
  //             createdAt = DateTime.now();
  //           }

  //           String formattedTime = timeago.format(createdAt);

  //           allFeedback.add({
  //             "fullName": userName,
  //             "branch": branch['branchAddress'],
  //             "channelName": branch['channelName'],
  //             "branchThumbnail": branch['branchThumbnail'],
  //             "image_title": feedback['image_title'],
  //             "imageUrl": feedback['imageUrl'],
  //             "rating": feedback['rating'].toString(),
  //             "created_at": formattedTime,
  //           });
  //         }
  //       }
  //     }
  //     feedbackList.assignAll(allFeedback);
  //   } catch (e) {
  //     Get.snackbar("Error", "Failed to fetch feedback: $e");
  //   }
  // }

