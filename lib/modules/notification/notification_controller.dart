import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/role_enum.dart';
import 'package:timeago/timeago.dart' as timeago;

class NotificationController extends GetxController {
  final UserRole role;
  NotificationController({required this.role});

  var notificationList = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();
      QuerySnapshot userQuery =
          await FirebaseFirestore.instance.collection('email_user').get();

      Map<String, Map<String, String>> userMap = {};
      for (var userDoc in userQuery.docs) {
        userMap[userDoc['uid']] = {
          "fullName": userDoc['fullName'] ?? "Unknown User",
          "profileImage": userDoc['profileImage'] ?? "",
        };
      }

      List<Map<String, dynamic>> allNotifications = [];
      String? currentUserBranchId;
      String currentUserId = FirebaseAuth.instance.currentUser!.uid;

      if (role == UserRole.manager) {
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
            String userId = feedback['user_id'] ?? '';
            String userName = userMap[userId]?["fullName"] ?? "Unknown User";
            String userProfile = userMap[userId]?["profileImage"] ?? "";

            if (role == UserRole.user && feedback['user_id'] != currentUserId) {
              continue;
            }

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

            allNotifications.add({
              "fullName": userName,
              "profileImage": userProfile,
              "image_url": feedback['image_url'] ?? "",
              "created_at": formattedTime,
            });
          }
        }
      }
      notificationList.assignAll(allNotifications);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch notifications: $e");
    }
  }
}
