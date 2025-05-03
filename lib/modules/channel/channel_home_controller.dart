import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/utils/app_alert.dart';

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

// Add these to your ChannelHomeController
  var textFeedbackCount = 0.obs;
  var imageFeedbackCount = 0.obs;
  var videoFeedbackCount = 0.obs;

  Future<void> fetchFeedbackCounts() async {
    try {
      final branchId = auth.currentUser?.uid;
      if (branchId == null) return;

      final snapshot = await firestore
          .collection('feedback')
          .where('branchId', isEqualTo: branchId)
          .get();

      int textCount = 0;
      int imageCount = 0;
      int videoCount = 0;

      for (var doc in snapshot.docs) {
        final data = doc.data();
        final category = data['category']?.toString() ?? '';

        if (category == 'text_feedback') {
          textCount++;
        } else if (category == 'image_feedback') {
          imageCount++;
        } else if (category == 'video_feedback') {
          videoCount++;
        }
      }

      textFeedbackCount.value = textCount;
      imageFeedbackCount.value = imageCount;
      videoFeedbackCount.value = videoCount;
    } catch (e) {
      log('Error fetching feedback counts: $e');
    }
  }

// Call this in your fetchInitialData method
  Future<void> fetchInitialData() async {
    try {
      isLoading(true);
      await fetchManagerData();
      await fetchFeedbackCounts(); // Add this line
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
