import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';

class UploadImageFeedbackController extends GetxController {
  final description = TextEditingController();
  final rating = TextEditingController();
  RxString selectedMealType = 'Breakfast'.obs;
  Rx<File?> selectedImage = Rx<File?>(null);
  RxBool isLoading = false.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> saveFeedback({
    required String description,
    required String rating,
    required String restaurantName,
    required String branchName,
  }) async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        isLoading.value = false;
        return;
      }

      if (selectedImage.value == null) {
        log("No image selected!");
        isLoading.value = false;
        return;
      }

      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference storageRef =
          FirebaseStorage.instance.ref().child('userImageFeedback/$fileName');

      UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc();

      await feedbackDoc.set({
        'feedbackId': feedbackDoc.id,
        'userId': user.uid,
        'restaurantName': restaurantName,
        'branchName': branchName,
        'description': description,
        'rating': rating,
        'mealType': selectedMealType.value,
        'imageUrl': imageUrl,
        'category': 'image_feedback',
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

      this.description.clear();
      this.rating.clear();
      selectedImage.value = null;
      selectedMealType.value = 'Breakfast';

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
      isLoading.value = false;
    }
  }

  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
