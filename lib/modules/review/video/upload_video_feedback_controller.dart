import 'package:get/get.dart';
import 'package:tasteclip/core/route/app_router.dart';

class UploadVideoFeedbackController extends GetxController {
  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }
}
