import 'package:flutter/material.dart';
import 'package:tasteclip/core/auth/phone.dart';
import 'package:tasteclip/core/auth/signin.dart';
import 'package:tasteclip/core/auth/signup.dart';
import 'package:tasteclip/core/auth/authentication.dart';
import 'package:tasteclip/core/auth/role.dart';
import 'package:tasteclip/modules/guest/guest.dart';
import 'package:tasteclip/modules/manager/manager_auth.dart';
import 'package:tasteclip/modules/onboarding/onboarding.dart';
import 'package:tasteclip/modules/onboarding/onboarding1.dart';
import 'package:tasteclip/modules/onboarding/onboarding2.dart';
import 'package:tasteclip/modules/splash/splash_logo.dart';
import 'package:tasteclip/modules/splash/splash_text.dart';
import 'package:tasteclip/utils/loader.dart';

class AppRouter {
  static const splashLogo = "/splashLogo";
  static const splashText = "/splashText";
  static const onboarding = "/onboarding";
  static const onboarding1 = "/onboarding1";
  static const onboarding2 = "/onboarding2";
  static const role = "/role";
  static const authentication = "/authentication";
  static const login = "/login";
  static const signup = "/signup";
  static const guest = "/guest";
  static const managerAuth = "/managerAuth";
  static const firstScreen = "/firstScreen";
  static const phoneAuth = "/phoneAuth";

  static final key = GlobalKey<NavigatorState>();

  static Route onGenerateRoute(RouteSettings settings) {
    debugPrint('Current Route: ${settings.name}');
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          settings: const RouteSettings(name: '/'),
          builder: (_) => const Scaffold(),
        );
      case AppRouter.splashLogo:
        return _navigate(const SplashLogo());

      case AppRouter.splashText:
        return _navigate(const SplashText());

      case AppRouter.onboarding:
        return _navigate(const Onboarding());

      case AppRouter.onboarding1:
        return _customNavigate(const Onboarding1(),
            transition: _rightToLeftTransition);

      case AppRouter.onboarding2:
        return _customNavigate(const Onboarding2(),
            transition: _fadeInTransition);

      case AppRouter.role:
        return _navigate(const Role());

      case AppRouter.authentication:
        return _navigate(const Authentication());

      case AppRouter.signup:
        return _customNavigate(const Signup(), transition: _fadeInTransition);

      case AppRouter.guest:
        return _navigate(const Guest());

      case AppRouter.managerAuth:
        return _navigate(const ManagerAuth());

      case AppRouter.login:
        return _customNavigate(const Signin(), transition: _fadeInTransition);

      case AppRouter.firstScreen:
        return _navigate(const FirstScreen());

      case AppRouter.phoneAuth:
        return _navigate(const PhoneAuth());

      default:
        return _errorRoute();
    }
  }

  static Route _errorRoute() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: '/error'),
      builder: (_) => Scaffold(
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

  static _navigate(Widget widget) {
    return MaterialPageRoute(builder: (_) => widget);
  }

  static Route _customNavigate(Widget widget,
      {required RouteTransitionsBuilder transition}) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: transition,
      transitionDuration: const Duration(milliseconds: 600),
    );
  }

  static Widget _rightToLeftTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    const begin = Offset(1.0, 0.0);
    const end = Offset.zero;
    const curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    var offsetAnimation = animation.drive(tween);

    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }

  static Widget _fadeInTransition(
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return FadeTransition(
      opacity: animation,
      child: child,
    );
  }

  static pushAndReplace(String route) {
    key.currentState!
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  static push(String route, {Object? arguments}) {
    key.currentState!.pushNamed(route, arguments: arguments);
  }

  static pushReplacementNamed(String route, {Object? arguments}) {
    key.currentState!.pushReplacementNamed(route, arguments: arguments);
  }

  static pop() {
    key.currentState!.pop();
  }
}
