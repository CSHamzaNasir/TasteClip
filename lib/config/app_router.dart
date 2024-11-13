import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/email/login_screen.dart';
import 'package:tasteclip/modules/auth/phone/phone_auth_screen.dart';
import 'package:tasteclip/modules/auth/phone/phone_otp_screen.dart';
import 'package:tasteclip/modules/auth/role/role_screen.dart';
import 'package:tasteclip/modules/auth/user_auth/user_auth_screen.dart';
import 'package:tasteclip/modules/manager/auth/channel_register_screen.dart';
import 'package:tasteclip/modules/manager/manager_auth_screen.dart';
import 'package:tasteclip/modules/review/Image/upload_image_feedback_screen.dart';
import 'package:tasteclip/modules/review/text/upload_text_feedback_screen.dart';
import 'package:tasteclip/modules/review/upload_feedback_screen.dart';
import 'package:tasteclip/modules/review/video/upload_video_feedback_screen.dart';
import 'package:tasteclip/modules/splash/splash_screen.dart';

import '../modules/auth/email/register_screen.dart';
import '../modules/manager/auth/channel_login_screen.dart';
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
  static const channelRegisterScreen = "/channelRegisterScreen";
  static const channelLoginScreen = "/channelLoginScreen";
  static const uploadFeedbackScreen = "/uploadFeedbackScreen";
  static const uploadTextFeedbackScreen = "/uploadTextFeedbackScreen";
  static const uploadImageFeedbackScreen = "/uploadImageFeedbackScreen";
  static const uploadVideoFeedbackScreen = "/uploadVideoFeedbackScreen";
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
  ];
}
