import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:tasteclip/core/auth/authentication.dart';
import 'package:tasteclip/core/auth/role.dart';
import 'package:tasteclip/modules/onboarding/onboarding.dart';
import 'package:tasteclip/modules/onboarding/onboarding1.dart';
import 'package:tasteclip/modules/onboarding/onboarding2.dart';
import 'package:tasteclip/modules/splash/splash_logo.dart';
import 'package:tasteclip/modules/splash/splash_text.dart';

class AppRouter {
  static const splashLogo = "/splashLogo";
  static const splashText = "/splashText";
  static const onboarding = "/onboarding";
  static const onboarding1 = "/onboarding1";
  static const onboarding2 = "/onboarding2";
  static const role = "/role";
  static const authentication = "/authentication";

  static final GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    debugPrint('Current Route: ${settings.name}');

    switch (settings.name) {
      case '/':
        return GetPageRoute(
          settings: const RouteSettings(name: '/'),
          page: () => const Scaffold(),
        );

      case splashLogo:
        return GetPageRoute(page: () => const SplashLogo());

      case splashText:
        return GetPageRoute(page: () => const SplashText());

      case onboarding:
        return GetPageRoute(page: () => const Onboarding());

      case onboarding1:
        return GetPageRoute(
          page: () => const Onboarding1(),
          transition: Transition.rightToLeft,
        );

      case onboarding2:
        return GetPageRoute(
          page: () => const Onboarding2(),
          transition: Transition.rightToLeft,
        );

      case role:
        return GetPageRoute(
          page: () => const Role(),
          transition: Transition.fadeIn,
          transitionDuration: const Duration(milliseconds: 600),
        );

      case authentication:
        return GetPageRoute(
          page: () => const Authentication(),
          transition: Transition.fadeIn,
        );

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return GetPageRoute(
      settings: const RouteSettings(name: '/error'),
      page: () => Scaffold(
        appBar: AppBar(
          title: const Text('Under development'),
        ),
        body: const Center(
          child: Text(
            'This Screen is currently under development!',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  static void pushAndReplace(String route, {Map<String, dynamic>? arguments}) {
    key.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static void popAndPush(String route, {Map<String, dynamic>? arguments}) {
    Get.back();
    Get.toNamed(route, arguments: arguments);
  }

  static void push(String route, {Map<String, dynamic>? arguments}) {
    Get.toNamed(route, arguments: arguments);
  }

  static void pop({dynamic value}) {
    Get.back(result: value);
  }
}
