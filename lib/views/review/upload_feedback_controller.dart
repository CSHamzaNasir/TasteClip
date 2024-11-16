import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class UploadFeedbackController extends GetxController {
  void goToUploadTxtFbScreen() {
    Get.toNamed(AppRouter.uploadTextFeedbackScreen);
  }
}
