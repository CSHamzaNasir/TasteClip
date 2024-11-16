import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:tasteclip/data/models/auth_models.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';
import '../../config/app_router.dart';

class UserProfileController extends GetxController {
  final AuthRepository authRepository;
  Rx<AuthModel?> user = Rx<AuthModel?>(null);
  PlatformFile? pickedFile;
  RxBool isLoading = false.obs;

  UserProfileController({required this.authRepository});

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user.value = await authRepository.fetchCurrentUserData();
    update();
  }

  Future<void> selectFile() async {
    isLoading.value = true;
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      pickedFile = result.files.first;
      update();
    }
    isLoading.value = false;
  }

  Future<void> uploadFile() async {
    if (pickedFile?.path == null) {
      if (kDebugMode) {
        print("No file selected.");
      }
      return;
    }

    try {
      final currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser == null) {
        if (kDebugMode) {
          print("No user is logged in.");
        }
        return;
      }

      final file = File(pickedFile!.path!);
      final path = 'user_images/${currentUser.uid}/${pickedFile!.name}';
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);

      final downloadURL = await ref.getDownloadURL();
      await FirebaseFirestore.instance
          .collection('email_user')
          .doc(currentUser.uid)
          .update({'profileImageUrl': downloadURL});

      user.value = user.value!.copyWith(profileImageUrl: downloadURL);
      update();

      if (kDebugMode) {
        print("Upload successful: ${pickedFile!.name}");
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error uploading file: $e");
      }
    }
  }

  void goToProfileDetailsScreen() {
    Get.toNamed(AppRouter.profileDetailScreen);
  }
}
