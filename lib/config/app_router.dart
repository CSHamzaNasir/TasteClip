import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/email/login_screen.dart';
import 'package:tasteclip/modules/auth/phone/phone_auth_screen.dart';
import 'package:tasteclip/modules/auth/phone/phone_otp_screen.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/auth/user_auth/user_auth_screen.dart';
import 'package:tasteclip/modules/manager/manager_auth_screen.dart';
import 'package:tasteclip/modules/splash/splash_screen.dart';

import '../modules/auth/email/register_screen.dart';
import '../modules/splash/onboarding/onboarding_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";
  static const userAuthScreen = "/userAuthScreen";
  static const registerScreen = "/registerScreen";
  static const loginScreen = "/loginScreen";
  static const phoneAuthScreen = "/phoneAuthScreen";
  static const otpScreen = "/otpScreen";
  static const phoneVerifyScreen = "/phoneVerifyScreen";
  static const managerAuthScreen = "/managerAuthScreen";

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
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userAuthScreen,
      page: () => UserAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: registerScreen,
      page: () => RegisterScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: loginScreen,
      page: () => LoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: phoneAuthScreen,
      page: () => PhoneAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: otpScreen,
      page: () => OtpScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    //////////////////////////////////////////////////////////////////////Manager Section
    GetPage(
      name: managerAuthScreen,
      page: () => ManagerAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
