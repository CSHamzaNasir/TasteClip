import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/bottombar/custom_bottom_bar.dart';
import 'package:tasteclip/modules/channel/channel_home_screen.dart';

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
      // Check if user is a manager
      bool isManager = await _checkIfManager(user.uid);

      if (isManager) {
        Get.off(() => ChannelHomeScreen());
      } else {
        await UserController.to.fetchAndStoreUserData(user.uid);
        Get.off(() => CustomBottomBar());
      }
    } else {
      goToOnboardingScreen();
    }
  }

  Future<bool> _checkIfManager(String uid) async {
    try {
      // Check if this user exists in the restaurants collection
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == uid) {
            return true;
          }
        }
      }
      return false;
    } catch (e) {
      log("Error checking manager status: $e");
      return false;
    }
  }

  void goToOnboardingScreen() {
    Get.offNamed(AppRouter.onBoardingScreen);
  }
}
