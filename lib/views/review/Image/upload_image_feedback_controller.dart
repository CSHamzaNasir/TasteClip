import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/config/app_router.dart';

class UploadImageFeedbackController extends GetxController {
  final imageTitle = TextEditingController();
  final description = TextEditingController();
  final rating = TextEditingController();
  final tagController = TextEditingController();
  RxList<String> tags = <String>[].obs;
  RxString selectedMealType = 'Breakfast'.obs;
  Rx<File?> selectedImage = Rx<File?>(null);

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      selectedImage.value = File(pickedFile.path);
    }
  }

void addTag() {
    if (tagController.text.isNotEmpty) {
      tags.add(tagController.text.trim());
      log("Tag Added: ${tags.toList()}");  
      tagController.clear();
      update();  
    }
  }


  void removeTag(String tag) {
    tags.remove(tag);
  }

  Future<void> saveFeedback({
    required String imageTitle,
    required String description,
    required String rating,
    required String restaurantName,
    required String branchName,
  }) async {
    try {
      if (selectedImage.value == null) {
        log("No image selected!");
        return;
      }

      String fileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
      Reference storageRef =
          FirebaseStorage.instance.ref().child('userImageFeedback/$fileName');

      UploadTask uploadTask = storageRef.putFile(selectedImage.value!);
      TaskSnapshot snapshot = await uploadTask;
      String imageUrl = await snapshot.ref.getDownloadURL();

      final restaurantDoc = FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantName);

      final restaurantSnapshot = await restaurantDoc.get();
      if (!restaurantSnapshot.exists) {
        log("Restaurant does not exist!");
        return;
      }

      final List<dynamic> branches = restaurantSnapshot['branches'] ?? [];
      List<dynamic> updatedBranches = [];

      for (var branch in branches) {
        if (branch['branchAddress'] == branchName) {
          List<dynamic> existingFeedback = branch['imageFeedback'] ?? [];
          existingFeedback.add({
            'image_title': imageTitle,
            'description': description,
            'rating': rating,
            'tags': tags.toList(),
            'meal_type': selectedMealType.value,
            'image_url': imageUrl,
            'created_at': DateTime.now().toIso8601String(),
          });
          branch['imageFeedback'] = existingFeedback;
        }
        updatedBranches.add(branch);
      }

      await restaurantDoc.update({'branches': updatedBranches});
      log("Feedback submitted successfully!");
    } catch (e) {
      log("Error saving feedback: $e");
    }
  }

  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
