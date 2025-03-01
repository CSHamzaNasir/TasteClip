import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/role_enum.dart';
import 'package:timeago/timeago.dart' as timeago;

class ImageFeedbackController extends GetxController {
  final UserRole role;
  ImageFeedbackController({required this.role});

  var feedbackList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchFeedback();
  }

  Future<void> fetchFeedback() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> allFeedback = [];
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
        List<dynamic> branches = restaurantDoc['branches'] ?? [];
        for (var branch in branches) {
          List<dynamic> feedbacks = branch['imageFeedback'] ?? [];
          for (var feedback in feedbacks) {
            if (role == UserRole.manager &&
                branch['branchId'] != currentUserBranchId) {
              continue;
            }
            DateTime createdAt;
            if (feedback['created_at'] is Timestamp) {
              createdAt = (feedback['created_at'] as Timestamp).toDate();
            } else if (feedback['created_at'] is String) {
              createdAt =
                  DateTime.tryParse(feedback['created_at']) ?? DateTime.now();
            } else {
              createdAt = DateTime.now();
            }

            String formattedTime = timeago.format(createdAt);

            allFeedback.add({
              "branch": branch['branchAddress'],
              "channelName": branch['channelName'],
              "branchThumbnail": branch['branchThumbnail'],
              "image_title": feedback['image_title'],
              "image_url": feedback['image_url'],
              "rating": feedback['rating'].toString(),
              "created_at": formattedTime,
            });
          }
        }
      }
      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch feedback: $e");
    }
  }
}
