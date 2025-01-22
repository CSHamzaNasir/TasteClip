import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChannelProfileEditController extends GetxController {
  final nameController = TextEditingController();

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString email = ''.obs;
  RxString channelName = ''.obs;
  RxString profileImageUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManagerData();
  }

  Future<void> fetchManagerData() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        final restaurantDoc = await firestore
            .collection('manager_credentials')
            .doc(user.uid)
            .get();

        if (restaurantDoc.exists) {
          final data = restaurantDoc.data();
          email.value = data?['email'] ?? '';
          channelName.value = data?['channelUsername'] ?? 'channelUsername';
          profileImageUrl.value = data?['channelProfile'] ?? '';
        } else {
          log('Document does not exist.');
        }
      } else {
        log('User not authenticated.');
      }
    } catch (e) {
      log('Error fetching manager data: $e');
    }
  }

  Future<void> updateProfile(String name, File? imageFile) async {
    try {
      final user = auth.currentUser;
      if (user == null) {
        Get.snackbar('Error', 'User not authenticated.',
            backgroundColor: Colors.red, colorText: Get.theme.cardColor);
        return;
      }

      final snapshot = await firestore
          .collection('manager_credentials')
          .where('channelUsername', isEqualTo: name)
          .get();

      if (snapshot.docs.isNotEmpty && snapshot.docs.first.id != user.uid) {
        Get.snackbar('Error', 'Channel name already exists.',
            backgroundColor: Colors.red, colorText: Get.theme.cardColor);
        return;
      }

      String? imageUrl;
      if (imageFile != null) {
        final storageRef =
            FirebaseStorage.instance.ref('profile_images/${user.uid}');
        final uploadTask = await storageRef.putFile(imageFile);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      final branchId = '${name}_${user.uid}';

      final updateData = {
        'channelUsername': name,
        'channelProfile': imageUrl ?? profileImageUrl.value,
        'branchId': branchId,
      };

      await firestore.collection('manager_credentials').doc(user.uid).set(
            updateData,
            SetOptions(merge: true),
          );

      channelName.value = name;
      if (imageUrl != null) profileImageUrl.value = imageUrl;

      Get.snackbar('Success', 'Profile updated successfully.',
          backgroundColor: Get.theme.primaryColor,
          colorText: Get.theme.cardColor);
    } catch (e) {
      log('Error updating profile: $e');
      Get.snackbar('Error', 'Something went wrong. Please try again.',
          backgroundColor: Colors.red, colorText: Get.theme.cardColor);
    }
  }

  void goToEditProfile() {
    Get.toNamed('/edit-profile');
  }

  void goToRoleScreen() {
    Get.toNamed('/role-screen');
  }
}
