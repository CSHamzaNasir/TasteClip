import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class ChannelProfileController extends GetxController {
  void goToRoleScreen() {
    Get.toNamed(AppRouter.roleScreen);
  }
}
