import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/views/bottombar/bottombar.dart';

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
    Get.to(ChannelBottomBar());
  }
}
