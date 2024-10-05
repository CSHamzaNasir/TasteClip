import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/views/auth/splash/onboarding/components/onboarding1.dart';

import '../../role/role_screen.dart';
import 'components/onboarding.dart';
import 'components/onboarding2.dart';

class OnboardingController extends GetxController {
  int selectedPage = 0;
  final PageController pageController = PageController();

  final List<Widget> onboardingWidgets = const [
    Onboarding(),
    Onboarding1(),
    Onboarding2()
  ];

  onPageChanged(index) {
    selectedPage = index;
    update();
  }

  void goToRoleScreen({required bool isSkip}) {
    if (isSkip) {
      Get.off(() => RoleScreen(), transition: Transition.fadeIn);
    } else {
      Get.off(() => RoleScreen(), transition: Transition.downToUp);
    }
  }
}
