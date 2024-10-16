import 'package:get/get.dart';
import 'package:tasteclip/views/auth/change_password/forget_password_screen.dart';
import 'package:tasteclip/views/auth/change_password/recover_password_screen.dart';
import 'package:tasteclip/views/auth/email/login_screen.dart';
import 'package:tasteclip/views/auth/role/role_screen.dart';
import 'package:tasteclip/views/auth/user_auth/user_auth_screen.dart';
import 'package:tasteclip/views/main/profile/complete_profile_screen.dart';
import 'package:tasteclip/views/manager/channel/channel_register_screen.dart';
import 'package:tasteclip/views/manager/manager_auth_screen.dart';
import 'package:tasteclip/views/auth/splash/splash_screen.dart';

import '../views/auth/email/register_screen.dart';
import '../views/manager/channel/channel_login_screen.dart';
import '../views/auth/splash/onboarding/onboarding_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";
  static const userAuthScreen = "/userAuthScreen";
  static const registerScreen = "/registerScreen";
  static const loginScreen = "/loginScreen";
  static const managerAuthScreen = "/managerAuthScreen";
  static const channelRegisterScreen = "/channelRegisterScreen";
  static const channelLoginScreen = "/channelLoginScreen";
  static const forgetPasswordScreen = "/forgetPasswordScreen";
  static const recoverPasswordScreen = "/recoverPasswordScreen";
  static const completeProfileScreen = "/completeProfileScreen";
  static final routes = [
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
      name: managerAuthScreen,
      page: () => ManagerAuthScreen(),
      transition: Transition.downToUp,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: channelRegisterScreen,
      page: () => ChannelRegisterScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: channelLoginScreen,
      page: () => ChannelLoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: recoverPasswordScreen,
      page: () => RecoverPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: completeProfileScreen,
      page: () => const CompleteProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
  ];
}
