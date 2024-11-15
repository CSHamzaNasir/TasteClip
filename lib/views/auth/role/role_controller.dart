import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class RoleController extends GetxController {
  void goToUserAuthSecreen() {
    Get.toNamed(AppRouter.userAuthScreen);
  }
}
