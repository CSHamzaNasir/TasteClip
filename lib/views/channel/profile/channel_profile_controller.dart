import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class ChannelProfileController extends GetxController {
  void goToAllRegisterScreen() {
    Get.toNamed(AppRouter.channelProfileEditScreen);
  }
}
