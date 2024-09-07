import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class SplashController extends GetxController {
  bool splashText = false;
  bool splashAppLogo = true;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 2), () {
      splashAppLogo = false;
      splashText = true;
      update();

      Future.delayed(const Duration(seconds: 2), () {
        goToOnboardingScreen();
      });
    });
  }

  void goToOnboardingScreen() {
    Get.offNamed(AppRouter.onBoardingScreen);
  }
}
