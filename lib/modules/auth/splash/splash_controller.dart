import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_approval_screen.dart';
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

// Update the _checkIfManager method in SplashController
  Future<int?> _getManagerStatus(String uid) async {
    try {
      QuerySnapshot restaurantQuery =
          await FirebaseFirestore.instance.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == uid) {
            return branch['status'] as int?;
          }
        }
      }
      return null;
    } catch (e) {
      log("Error checking manager status: $e");
      return null;
    }
  }

  void _checkUserStatus() async {
    User? user = FirebaseAuth.instance.currentUser;

    log("DEBUG: User is ${user != null ? 'LOGGED IN' : 'NULL'}");

    if (user != null) {
      // Check manager status
      int? managerStatus = await _getManagerStatus(user.uid);

      if (managerStatus != null) {
        // This is a manager
        switch (managerStatus) {
          case 1: // Approved
            Get.off(() => ChannelHomeScreen());
            break;
          case 0: // Pending approval
            Get.off(() => ManagerApprovalScreen(
                  status: ManagerApprovalStatus.pending,
                ));
            break;
          case 2: // Rejected
            Get.off(() => ManagerApprovalScreen(
                  status: ManagerApprovalStatus.rejected,
                ));
            break;
          default:
            Get.off(() => ManagerApprovalScreen(
                  status: ManagerApprovalStatus.pending,
                ));
        }
      } else {
        // Regular user
        await UserController.to.fetchAndStoreUserData(user.uid);
        Get.off(() => CustomBottomBar());
      }
    } else {
      goToOnboardingScreen();
    }
  }

  void goToOnboardingScreen() {
    Get.offNamed(AppRouter.onBoardingScreen);
  }
}
