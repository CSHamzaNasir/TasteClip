import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class RoleController extends GetxController {
  void goToUserAuthSecreen() {
    Get.toNamed(AppRouter.userAuthScreen);
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRouter.registerScreen);
  }

  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToManagerAuthScreen() {
    Get.toNamed(AppRouter.managerRegisterScreen);
  }
}
