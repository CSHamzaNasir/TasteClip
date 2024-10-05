import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class UserAuthController extends GetxController {
  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
