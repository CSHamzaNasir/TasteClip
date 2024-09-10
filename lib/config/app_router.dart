import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/auth/user_auth_screen.dart';
import 'package:tasteclip/modules/splash/splash_screen.dart';

import '../modules/splash/onboarding/onboarding_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";
  static const userAuthScreen = "/userAuthScreen";

  static final routes = [
    //////////////////////////////////////////////////////////////////////////////// splash section
    GetPage(
      name: splashScreen,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: onBoardingScreen,
      page: () => OnboardingScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    //////////////////////////////////////////////////////////////////////////////// user auth section
    GetPage(
      name: roleScreen,
      page: () => RoleScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 700),
    ),
    GetPage(
      name: userAuthScreen,
      page: () => const UserAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
