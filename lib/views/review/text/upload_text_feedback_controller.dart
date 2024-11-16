import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class UploadTextFeedbackController extends GetxController {
  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
