import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class HomeController extends GetxController {
  void goToProfileScreen() {
    Get.toNamed(AppRouter.userProfileScreen);
  }

  void goToWatchFeedbackScreen() {
    Get.toNamed(AppRouter.watchFeedbackScreen);
  }

  void goToAllRegisterScreen() {
    Get.toNamed(AppRouter.allRestaurantScreen);
  }
}
