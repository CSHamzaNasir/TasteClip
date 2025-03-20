import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class UserProfileEditController extends GetxController {
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString userName = ''.obs;
  RxString fullName = ''.obs;
  RxString profileImage = ''.obs;
  RxBool isLoading = false.obs; // Add this line

  Future<void> updateProfile({
    required String updatedUserName,
    required String updatedFullName,
    File? imageFile,
  }) async {
    try {
      isLoading.value = true; // Set loading to true
      final user = auth.currentUser;
      if (user != null) {
        String? imageUrl;
        if (imageFile != null) {
          final storageRef =
              FirebaseStorage.instance.ref('user_images/${user.uid}');
          final uploadTask = await storageRef.putFile(imageFile);
          imageUrl = await uploadTask.ref.getDownloadURL();
        }

        await firestore.collection('email_user').doc(user.uid).update({
          'userName': updatedUserName,
          'fullName': updatedFullName,
          'profileImage': imageUrl ?? profileImage.value,
        });

        // Update local variables
        userName.value = updatedUserName;
        fullName.value = updatedFullName;
        if (imageUrl != null) profileImage.value = imageUrl;

        Get.snackbar(
          'Success!',
          'Your Profile updated successfully.',
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
      }
    } catch (e) {
      log('Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void goToEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void goToRoleScreen() {
    Get.toNamed('/role-screen');
  }

  @override
  void onClose() {
    userNameController.dispose();
    fullNameController.dispose();
    super.onClose();
  }
}
