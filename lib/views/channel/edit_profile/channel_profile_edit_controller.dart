import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';
import 'package:tasteclip/utils/app_alert.dart';

class ChannelProfileEditController extends GetxController {
  var channelNameController = TextEditingController();
  var imageFile = Rx<File?>(null);
  var isLoading = false.obs;
  final picker = ImagePicker();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    loadBranchData();
  }

  void loadBranchData() async {
    String userId = auth.currentUser!.uid;
    QuerySnapshot restaurantQuery =
        await firestore.collection('restaurants').get();
    for (var doc in restaurantQuery.docs) {
      List<dynamic> branches = doc['branches'];
      for (var branch in branches) {
        if (branch['branchId'] == userId) {
          channelNameController.text = branch['channelName'];
          break;
        }
      }
    }
  }

  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  Future<void> updateBranch() async {
    isLoading.value = true;
    try {
      String? imageUrl;
      String userId = auth.currentUser!.uid;
      String? restaurantName;
      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();
      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == userId) {
            restaurantName = doc.id;
            break;
          }
        }
        if (restaurantName != null) break;
      }

      if (restaurantName == null) {
        AppAlerts.showSnackbar(
            isSuccess: false, message: "Restaurant not found");
        return;
      }

      if (imageFile.value != null) {
        String fileName = "branches/$userId.jpg";
        TaskSnapshot uploadTask = await FirebaseStorage.instance
            .ref(fileName)
            .putFile(imageFile.value!);
        imageUrl = await uploadTask.ref.getDownloadURL();
      }

      DocumentSnapshot restaurantDoc =
          await firestore.collection('restaurants').doc(restaurantName).get();
      List<dynamic> branches = restaurantDoc['branches'];
      for (var i = 0; i < branches.length; i++) {
        if (branches[i]['branchId'] == userId) {
          branches[i]['branchThumbnail'] =
              imageUrl ?? branches[i]['branchThumbnail'];
          branches[i]['channelName'] = channelNameController.text.trim();
        }
      }

      await firestore
          .collection('restaurants')
          .doc(restaurantName)
          .update({'branches': branches});
      AppAlerts.showSnackbar(
          isSuccess: true, message: "Branch updated successfully");
      Get.back();
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
    isLoading.value = false;
  }
}
