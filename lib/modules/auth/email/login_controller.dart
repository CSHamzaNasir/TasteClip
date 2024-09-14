import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class LoginController extends GetxController {
  void goToLoginScreen() {
    Get.toNamed(AppRouter.registerScreen);
  }

  void goToPhoneVerifyScreen() {
    Get.toNamed(AppRouter.phoneVerifyScreen);
  }
}
