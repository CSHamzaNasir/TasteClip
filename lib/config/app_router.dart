import 'package:get/get.dart';
import 'package:tasteclip/modules/splash/splash_screen.dart';

class AppRouter {
  static const splashScreen = "/splashScreen";

  static final routes = [
    GetPage(name: splashScreen, page: () => const SplashScreen())
  ];
}
