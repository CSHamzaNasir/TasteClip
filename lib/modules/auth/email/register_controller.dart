import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class RegisterController extends GetxController {
  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToPhoneVerifyScreen() {
    Get.toNamed(AppRouter.phoneVerifyScreen);
  }
}
