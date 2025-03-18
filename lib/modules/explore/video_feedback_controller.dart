import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

class VideoFeedbackController extends GetxController {
  RxList<Map<String, dynamic>> videoFeedbacks = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVideoFeedbacks();
  }

  Future<void> fetchVideoFeedbacks() async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        isLoading.value = false;
        return;
      }

      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('category', isEqualTo: 'video_feedback')
          .orderBy('createdAt', descending: true)
          .get();

      videoFeedbacks.value = querySnapshot.docs.map((doc) {
        return doc.data() as Map<String, dynamic>;
      }).toList();

      log("Video feedbacks fetched successfully!");
    } catch (e) {
      log("Error fetching video feedbacks: $e");

      Get.snackbar(
        'Error!',
        'Failed to fetch video feedbacks. Please try again.',
        icon: Icon(Icons.error),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withCustomOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
