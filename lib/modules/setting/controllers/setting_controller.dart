import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';

class SettingController extends GetxController {
  var isDarkMode = false.obs;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed(AppRouter.splashScreen);
    } catch (e) {
      log('Error logging out: $e');
    }
  }

  void goToSettingProfileScreen() {
    Get.toNamed(AppRouter.settingProfileScreen);
  }

  void goToLegalScreen() {
    log("message");
    Get.toNamed(AppRouter.legalScreen);
  }
}
