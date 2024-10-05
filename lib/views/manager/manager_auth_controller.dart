import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class ManagerAuthController extends GetxController {
  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToChannelLogionScreen() {
    Get.toNamed(AppRouter.channelLoginScreen);
  }

  void goToChannelRegisterScreen() {
    Get.toNamed(AppRouter.channelRegisterScreen);
  }
}
