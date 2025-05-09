import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/change_password/forget_password_screen.dart';
import 'package:tasteclip/modules/auth/email/login_screen.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_auth_screen.dart';
import 'package:tasteclip/modules/auth/manager_auth/manager_login_screen.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/auth/splash/splash_screen.dart';
import 'package:tasteclip/modules/auth/user_auth/user_auth_screen.dart';
import 'package:tasteclip/modules/channel/channel_home_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_screen.dart';
import 'package:tasteclip/modules/home/home_screen.dart';
import 'package:tasteclip/modules/home/restaurant/restaurant_list_screen.dart'; 
import 'package:tasteclip/modules/profile/user_profile_screen.dart';
import 'package:tasteclip/modules/setting/legal/legal_screen.dart';
import 'package:tasteclip/modules/setting/setting_profile_screen.dart';
import 'package:tasteclip/modules/setting/setting_screen.dart';

import '../../modules/auth/email/register_screen.dart';
import '../../modules/auth/manager_auth/manager_register_screen.dart';
import '../../modules/auth/splash/onboarding/onboarding_screen.dart';
import '../../modules/channel/edit_profile/channel_profile_edit_screen.dart';
import '../../modules/profile/edit_profile/user_profile_edit_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";
  static const userAuthScreen = "/userAuthScreen";
  static const registerScreen = "/registerScreen";
  static const loginScreen = "/loginScreen";
  static const forgetPasswordScreen = "/forgetPasswordScreen";
  static const recoverPasswordScreen = "/recoverPasswordScreen";
  static const userProfileScreen = "/userProfileScreen";
  static const uploadTextFeedbackScreen = "/uploadTextFeedbackScreen";
  static const uploadImageFeedbackScreen = "/uploadImageFeedbackScreen";
  static const uploadVideoFeedbackScreen = "/uploadVideoFeedbackScreen";
  static const homeScreen = "/homeScreen";
  static const managerAuthScreen = "/managerAuthScreen";
  static const managerRegisterScreen = "/managerRegisterScreen";
  static const managerLoginScreen = "/managerLoginScreen";
  static const channelHomeScreen = "/channelHomeScreen";
  static const allRestaurantScreen = "/allRestaurantScreen";
  static const channelProfileEditScreen = "/channelProfileEditScreen";
  static const userProfileEditScreen = "/userProfileEditScreen";
  static const watchFeedbackScreen = "/watchFeedbackScreen"; 
  static const settingScreen = "/settingScreen";
  static const settingProfileScreen = "/settingProfileScreen";
  static const legalScreen = "/legalScreen";
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
      name: forgetPasswordScreen,
      page: () => const ForgetPasswordScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userProfileScreen,
      page: () => UserProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: homeScreen,
      page: () => HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: managerAuthScreen,
      page: () => ManagerAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: managerRegisterScreen,
      page: () => ManagerRegisterScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: managerLoginScreen,
      page: () => ManagerLoginScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: channelHomeScreen,
      page: () => ChannelHomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: allRestaurantScreen,
      page: () => RestaurantListScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: channelProfileEditScreen,
      page: () => ChannelProfileEditScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: userProfileEditScreen,
      page: () => UserProfileEditScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: watchFeedbackScreen,
      page: () => WatchFeedbackScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
 
    GetPage(
      name: settingScreen,
      page: () => SettingScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: settingProfileScreen,
      page: () => SettingProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: legalScreen,
      page: () => LegalScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
