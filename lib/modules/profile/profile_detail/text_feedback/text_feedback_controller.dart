import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:timeago/timeago.dart' as timeago;

class TextFeedbackController extends GetxController {
  final UserRole role;

  TextFeedbackController({required this.role});

  var feedbackListText = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedbackText();
  }

  Future<void> fetchFeedbackText() async {
    try {
      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

          

      List<Map<String, dynamic>> allFeedbackText = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) => feedbackData['category'] == "text_feedback")
          .map((feedbackData) {
        DateTime createdAt = feedbackData['createdAt'].toDate();
        return {
          "feedbackId": feedbackData['feedbackId'],
          "branch": feedbackData['branchName'],
          "branchThumbnail": feedbackData['branchThumbnail'],
          "review": feedbackData['review'],
          "rating": feedbackData['rating'].toString(),
          "created_at": timeago.format(createdAt),
          "meal_type": feedbackData['mealType'],
          "restaurantName": feedbackData['restaurantName'],
        };
      }).toList();

      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch text feedback: $e");
    }
  }
}
