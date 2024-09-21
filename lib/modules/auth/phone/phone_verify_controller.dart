import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class PhoneVerifyController extends GetxController {
  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
