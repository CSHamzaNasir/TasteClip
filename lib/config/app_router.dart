import 'package:get/get.dart';
import 'package:tasteclip/views/auth/change_password/forget_password_screen.dart';
import 'package:tasteclip/views/auth/email/login_screen.dart';
import 'package:tasteclip/views/auth/manager_auth/manager_auth_screen.dart';
import 'package:tasteclip/views/auth/role/role_screen.dart';
import 'package:tasteclip/views/auth/splash/splash_screen.dart';
import 'package:tasteclip/views/auth/user_auth/user_auth_screen.dart';
import 'package:tasteclip/views/main/home/home_screen.dart';
import 'package:tasteclip/views/profile/profile_detail/profile_details_screen.dart';
import 'package:tasteclip/views/profile/user_profile_screen.dart';

import '../views/auth/email/register_screen.dart';
import '../views/auth/splash/onboarding/onboarding_screen.dart';
import '../views/review/Image/upload_image_feedback_screen.dart';
import '../views/review/text/upload_text_feedback_screen.dart';
import '../views/review/upload_feedback_screen.dart';
import '../views/review/video/upload_video_feedback_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";
  static const onBoardingScreen = "/onBoardingScreen";
  static const roleScreen = "/roleScreen";
  static const userAuthScreen = "/userAuthScreen";
  static const registerScreen = "/registerScreen";
  static const loginScreen = "/loginScreen";
  static const channelRegisterScreen = "/channelRegisterScreen";
  static const channelLoginScreen = "/channelLoginScreen";
  static const forgetPasswordScreen = "/forgetPasswordScreen";
  static const recoverPasswordScreen = "/recoverPasswordScreen";
  static const userProfileScreen = "/userProfileScreen";
  static const uploadFeedbackScreen = "/uploadFeedbackScreen";
  static const uploadTextFeedbackScreen = "/uploadTextFeedbackScreen";
  static const uploadImageFeedbackScreen = "/uploadImageFeedbackScreen";
  static const uploadVideoFeedbackScreen = "/uploadVideoFeedbackScreen";
  static const profileDetailScreen = "/profileDetailScreen";
  static const homeScreen = "/homeScreen";
  static const managerAuthScreen = "/managerAuthScreen";
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
    //////////////////////////////////////////////////////////////////////Upload Feedback
    GetPage(
      name: uploadFeedbackScreen,
      page: () => UploadFeedbackScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: uploadTextFeedbackScreen,
      page: () => UploadTextFeedbackScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: uploadImageFeedbackScreen,
      page: () => UploadImageFeedbackScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: uploadVideoFeedbackScreen,
      page: () => UploadVideoFeedbackScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: userProfileScreen,
      page: () => const UserProfileScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 500),
    ),
    GetPage(
      name: profileDetailScreen,
      page: () => const ProfileDetailsScreen(),
      transition: Transition.rightToLeft,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: homeScreen,
      page: () => const HomeScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
    GetPage(
      name: managerAuthScreen,
      page: () => const ManagerAuthScreen(),
      transition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
    ),
  ];
}
