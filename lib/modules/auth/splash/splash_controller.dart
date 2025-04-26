import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';

class SplashController extends GetxController {
  bool splashText = false;
  bool splashAppLogo = true;

  @override
  void onInit() {
    super.onInit();

    Future.delayed(const Duration(seconds: 1), () {
      splashAppLogo = false;
      splashText = true;
      update();

      Future.delayed(const Duration(seconds: 1), () {
        _checkUserStatus();
      });
    });
  }

  void _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");

    if (user != null) {
      await UserController.to.fetchAndStoreUserData(user.uid);
      Get.off(() => CustomBottomBar());
    } else {
      goToOnboardingScreen();
    }
  }

  void goToOnboardingScreen() {
    Get.offNamed(AppRouter.onBoardingScreen);
  }
}
