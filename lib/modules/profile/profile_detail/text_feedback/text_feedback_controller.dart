import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedbackText = [];
      String? currentUserBranchId;

      if (role == UserRole.manager) {
        String currentUserId = FirebaseAuth.instance.currentUser!.uid;

        for (var restaurantDoc in restaurantQuery.docs) {
          List<dynamic> branches = restaurantDoc['branches'] ?? [];
          for (var branch in branches) {
            if (branch['branchId'] == currentUserId) {
              currentUserBranchId = branch['branchId'];
              break;
            }
          }
          if (currentUserBranchId != null) break;
        }
      }

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branchesText = restaurantDoc['branches'] ?? [];
        for (var branchText in branchesText) {
          if (role == UserRole.manager &&
              branchText['branchId'] != currentUserBranchId) {
            continue;
          }

          List<dynamic> feedbacksText = branchText['textFeedback'] ?? [];
          for (var feedbackText in feedbacksText) {
            DateTime createdAt;
            if (feedbackText['created_at'] is Timestamp) {
              createdAt = (feedbackText['created_at'] as Timestamp).toDate();
            } else if (feedbackText['created_at'] is String) {
              createdAt = DateTime.tryParse(feedbackText['created_at']) ??
                  DateTime.now();
            } else {
              createdAt = DateTime.now();
            }

            String formattedTime = timeago.format(createdAt);

            allFeedbackText.add({
              "branch": branchText['branchAddress'],
              "branchThumbnail": branchText['branchThumbnail'],
              "feedback_text": feedbackText['feedback_text'],
              "rating": feedbackText['rating'].toString(),
              "created_at": formattedTime,
            });
          }
        }
      }
      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch feedback: $e");
    }
  }
}
