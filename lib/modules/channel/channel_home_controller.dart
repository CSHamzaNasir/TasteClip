import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/utils/app_alert.dart';
import 'package:timeago/timeago.dart' as timeago;

class ChannelHomeController extends GetxController {
  final List<Map<String, String>> mealCategories = [
    {"image": "assets/images/breakfast.png", "title": "Breakfast"},
    {"image": "assets/images/lunch.png", "title": "Lunch"},
    {"image": "assets/images/dinner.png", "title": "Dinner"},
  ];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  var isLoading = true.obs;
  var managerData = Rxn<Map<String, dynamic>>();
  var feedbackList = <Map<String, dynamic>>[].obs;

  String get branchId => auth.currentUser?.uid ?? 'No branch ID';

  @override
  void onInit() {
    super.onInit();
    fetchInitialData();
  }

  Future<void> fetchInitialData() async {
    try {
      isLoading(true);
      await fetchManagerData();
      await fetchBranchFeedback();
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Failed to load data: $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> fetchManagerData() async {
    try {
      User? user = auth.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'] ?? [];
        for (var branch in branches) {
          if (branch['branchId'] == user.uid) {
            managerData.value = {
              'restaurantName': doc.id,
              'branchEmail': branch['branchEmail'] ?? '',
              'branchAddress': branch['branchAddress'] ?? 'No address',
              'status': branch['status'] ?? 'inactive',
              'branchThumbnail': branch['branchThumbnail'] ?? '',
            };
            return;
          }
        }
      }
      throw Exception("Manager data not found");
    } catch (e) {
      managerData.value = null;
      rethrow;
    }
  }

  Future<void> fetchBranchFeedback() async {
    try {
      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();
      List<Map<String, dynamic>> allFeedback = [];

      for (var restaurantDoc in restaurantQuery.docs) {
        List<dynamic> branches = restaurantDoc['branches'] ?? [];

        for (var branch in branches) {
          if (branch.containsKey('imageFeedback')) {
            List<dynamic> feedbacks = branch['imageFeedback'] ?? [];

            for (var feedback in feedbacks) {
              DateTime createdAt;
              if (feedback['created_at'] is Timestamp) {
                createdAt = (feedback['created_at'] as Timestamp).toDate();
              } else if (feedback['created_at'] is String) {
                createdAt =
                    DateTime.tryParse(feedback['created_at']) ?? DateTime.now();
              } else {
                createdAt = DateTime.now();
              }

              allFeedback.add({
                "branch": branch['branchAddress'] ?? 'Unknown branch',
                "channelName": branch['channelName'] ?? '',
                "branchThumbnail": branch['branchThumbnail'] ?? '',
                "image_title": feedback['image_title'] ?? '',
                "imageUrl": feedback['imageUrl'] ?? '',
                "rating": feedback['rating']?.toString() ?? '0',
                "created_at": timeago.format(createdAt),
              });
            }
          }
        }
      }
      feedbackList.assignAll(allFeedback);
    } catch (e) {
      feedbackList.clear();
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Failed to load feedback: $e");
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      managerData.value = null;
      feedbackList.clear();
      isLoading.value = true;
      Get.offAllNamed(AppRouter.splashScreen);
    } catch (e) {
      log('Error logging out: $e');
    }
  }
}
