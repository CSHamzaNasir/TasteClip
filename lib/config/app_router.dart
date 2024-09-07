import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/splash/splash_screen.dart';

import '../modules/splash/onboarding/onboarding_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";

  static final routes = [
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: onBoardingScreen,
      page: () => OnboardingScreen(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: roleScreen,
      page: () => const RoleScreen(),
      transition: Transition.downToUp,
    ),
  ];
}
