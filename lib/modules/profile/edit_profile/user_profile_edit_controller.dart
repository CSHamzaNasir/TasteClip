import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfileEditController extends GetxController {
  final userNameController = TextEditingController();
  final fullNameController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString userName = ''.obs;
  RxString fullName = ''.obs;
  RxString profileImage = ''.obs;

  Future<void> updateProfile({
    required String updatedUserName,
    required String updatedFullName,
    File? imageFile,
  }) async {
    try {
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
          'Success',
          'Profile updated successfully.',
          backgroundColor: Get.theme.primaryColor,
          colorText: Colors.white,
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
