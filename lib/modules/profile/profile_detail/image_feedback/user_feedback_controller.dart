import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class UserFeedbackController extends GetxController {
  final UserRole role;
  UserFeedbackController({required this.role});

  var feedbackList = <Map<String, dynamic>>[].obs;
  var imageFeedbackCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserFeedback();
  }

  Future<void> fetchUserFeedback() async {
    try {
      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      String currentUserId = Get.find<UserController>().currentUserId.value;

      List<Map<String, dynamic>> allFeedback = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) {
        if (role == UserRole.user) {
          return feedbackData['userId'] == currentUserId &&
              (feedbackData['category'] == "image_feedback" ||
                  feedbackData['category'] == "video_feedback");
        }
        return feedbackData['category'] == "image_feedback" ||
            feedbackData['category'] == "video_feedback";
      }).map((feedbackData) {
        DateTime createdAt = feedbackData['createdAt'].toDate();
        return {
          "feedbackId": feedbackData['feedbackId'],
          "branch": feedbackData['branchName'],
          "restaurantName": feedbackData['restaurantName'],
          "branchThumbnail": feedbackData['branchThumbnail'],
          "image_title": feedbackData['imageTitle'],
          "description": feedbackData['description'],
          "imageUrl": feedbackData['imageUrl'],
          "mediaUrl": feedbackData['mediaUrl'],
          "rating": feedbackData['rating'].toString(),
          "created_at": timeago.format(createdAt),
          "meal_type": feedbackData['mealType'],
          "userId": feedbackData['userId'],
          "category": feedbackData['category'],
        };
      }).toList();

      feedbackList.assignAll(allFeedback);
      imageFeedbackCount.value = allFeedback
          .where((feedback) => feedback['category'] == "image_feedback")
          .length;
      update();
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch feedback: $e");
    }
  }
}
