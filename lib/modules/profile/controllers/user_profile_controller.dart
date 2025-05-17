import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../core/route/app_router.dart';

class UserProfileController extends GetxController {
  List<Map<String, dynamic>> feedbackOptions = [
    {'label': "Text", 'count': 0},
    {'label': "Image", 'count': 0},
    {'label': "Video", 'count': 0},
  ];

  var selectedIndex = 0.obs;
  final List<String> categories = ["Recent", "Saved"];

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final RxString uid = ''.obs;
  final RxString fullName = ''.obs;
  final RxString userName = ''.obs;
  final RxString email = ''.obs;
  final RxString profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentUserData();
    fetchFeedbackCounts();
  }

  Future<void> fetchFeedbackCounts() async {
    try {
      final user = auth.currentUser;
      if (user == null) return;

      final textCount = await firestore
          .collection('feedback')
          .where('userId', isEqualTo: user.uid)
          .where('category', isEqualTo: 'text_feedback')
          .count()
          .get();

      final imageCount = await firestore
          .collection('feedback')
          .where('userId', isEqualTo: user.uid)
          .where('category', isEqualTo: 'image_feedback')
          .count()
          .get();

      final videoCount = await firestore
          .collection('feedback')
          .where('userId', isEqualTo: user.uid)
          .where('category', isEqualTo: 'video_feedback')
          .count()
          .get();

      feedbackOptions[0]['count'] = textCount.count;
      feedbackOptions[1]['count'] = imageCount.count;
      feedbackOptions[2]['count'] = videoCount.count;

      update(); // Notify listeners
    } catch (e) {
      log('Error fetching feedback counts: $e');
    }
  }

  void changeCategory(int index) {
    selectedIndex.value = index;
  }

  void goToHomeScreen() {
    Get.offAllNamed(AppRouter.homeScreen);
  }

  void goToEditProfileScreen() {
    Get.toNamed(AppRouter.userProfileEditScreen);
  }

  void goToSettingScreen() {
    Get.toNamed(AppRouter.settingScreen);
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
          profileImage.value = userDoc['profileImage'] ?? '';
          userName.value = userDoc['userName'] ?? '';
        }
      }
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(AppRouter.splashScreen);
    } catch (e) {
      log('Error logging out: $e');
    }
  }
}
