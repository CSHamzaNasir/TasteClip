import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';

class UploadTextFeedbackController extends GetxController {
  final TextEditingController textFeedback = TextEditingController();
  final TextEditingController rating = TextEditingController();
  RxBool isLoading = false.obs;

  Future<void> saveFeedback({
    required String restaurantName,
    required String branchName,
    required String rating,
    required String textFeedback,
  }) async {
    try {
      isLoading(true);
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        Get.snackbar(
          'Error',
          'User not logged in!',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc();

      await feedbackDoc.set({
        'review': textFeedback,
        'feedbackId': feedbackDoc.id,
        'userId': user.uid,
        'restaurantName': restaurantName,
        'branchName': branchName,
        'rating': rating,
        'category': 'text_feedback',
        'createdAt': DateTime.now(),
        'comments': [],
      });

      log("Feedback submitted successfully!");

      Get.snackbar(
        'Success!',
        'Your feedback has been uploaded successfully.',
        icon: Icon(
          Icons.verified,
          color: AppColors.lightColor,
        ),
        snackPosition: SnackPosition.TOP,
        backgroundColor: AppColors.mainColor.withCustomOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );

      this.textFeedback.clear();
      this.rating.clear();
      Get.off(CustomBottomBar());
    } catch (e) {
      log("Error saving feedback: $e");
      Get.snackbar(
        'Error!',
        'Failed to upload feedback. Please try again.',
        icon: Icon(Icons.error),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.withCustomOpacity(0.9),
        colorText: Colors.white,
        borderRadius: 10,
        margin: const EdgeInsets.all(10),
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading(false);
    }
  }
}
