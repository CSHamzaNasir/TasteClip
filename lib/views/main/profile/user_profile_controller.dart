import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../../config/app_assets.dart';
import '../../../config/app_router.dart';

class UserProfileController extends GetxController {
//list
  List<Map<String, dynamic>> feedbackOptions = [
    {'icon': AppAssets.message, 'label': "Text"},
    {'icon': AppAssets.camera, 'label': "Image"},
    {'icon': AppAssets.video, 'label': "Video"},
  ];

  void goToHomeScreen() {
    Get.offAllNamed(AppRouter.homeScreen);
  }

  void goToEditProfileScreen() {
    Get.toNamed(AppRouter.userProfileEditScreen);
  }

  void goToProfileDetailScreen() {
    Get.toNamed(AppRouter.profileDetailScreen);
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  RxString email = ''.obs;
  RxString fullName = ''.obs;
  // ignore: non_constant_identifier_names
  RxString profile_image = ''.obs;
  RxString userName = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
  }

  Future<void> fetchCurrentUserData() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        final userDoc =
            await firestore.collection('email_user').doc(user.uid).get();

        if (userDoc.exists) {
          email.value = userDoc['email'] ?? '';
          fullName.value = userDoc['fullName'] ?? '';
          profile_image.value = userDoc['profile_image'] ?? '';
          userName.value = userDoc['userName'] ?? '';
        }
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }
}
