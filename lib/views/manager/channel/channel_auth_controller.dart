import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class ChannelAuthController extends GetxController {
  void goToChanelLoginScreen() {
    Get.toNamed(AppRouter.channelLoginScreen);
  }

  void goToChanelRegisterScreen() {
    Get.toNamed(AppRouter.channelRegisterScreen);
  }
}
