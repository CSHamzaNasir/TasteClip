import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';

class UploadFeedbackController extends GetxController {
  final TextEditingController description = TextEditingController();
  Rx<File?> selectedImage = Rx<File?>(null);
  Rx<File?> selectedVideo = Rx<File?>(null);
  RxBool isLoading = false.obs;
  RxDouble rating = 0.0.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

  Future<void> pickVideo({required ImageSource source}) async {
    final pickedFile = await ImagePicker().pickVideo(source: source);
    if (pickedFile != null) {
      selectedVideo.value = File(pickedFile.path);
    }
  }

  Future<void> showVideoSourceChoice() async {
    Get.bottomSheet(
      Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.video_library),
              title: Text('Upload from Gallery'),
              onTap: () async {
                Get.back();
                await pickVideo(source: ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.videocam),
              title: Text('Capture Video'),
              onTap: () async {
                Get.back();
                await pickVideo(source: ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> saveFeedback({
    required String description,
    required double rating,
    required String restaurantName,
    required String branchName,
    required FeedbackCategory category,
  }) async {
    try {
      isLoading.value = true;

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        isLoading.value = false;
        return;
      }

      String? mediaUrl;
      String categoryString;

      if (category == FeedbackCategory.image) {
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
        mediaUrl = await snapshot.ref.getDownloadURL();
        categoryString = 'image_feedback';
      } else if (category == FeedbackCategory.video) {
        if (selectedVideo.value == null) {
          log("No video selected!");
          isLoading.value = false;
          return;
        }

        String fileName = "${DateTime.now().millisecondsSinceEpoch}.mp4";
        Reference storageRef =
            FirebaseStorage.instance.ref().child('userVideoFeedback/$fileName');

        UploadTask uploadTask = storageRef.putFile(selectedVideo.value!);
        TaskSnapshot snapshot = await uploadTask;
        mediaUrl = await snapshot.ref.getDownloadURL();
        categoryString = 'video_feedback';
      } else {
        categoryString = 'text_feedback';
      }

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc();

      final feedback = UploadFeedbackModel(
        feedbackId: feedbackDoc.id,
        userId: user.uid,
        restaurantName: restaurantName,
        branchName: branchName,
        description: description,
        rating: rating,
        mediaUrl: mediaUrl,
        category: categoryString,
        createdAt: DateTime.now(),
        comments: [],
      );

      await feedbackDoc.set(feedback.toMap());

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

      clearForm();
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

  void clearForm() {
    description.clear();
    rating.value = 0.0;
    selectedImage.value = null;
    selectedVideo.value = null;
  }

  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
