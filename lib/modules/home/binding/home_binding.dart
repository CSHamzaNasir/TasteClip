import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/splash/controller/local_user_controller.dart';
import 'package:tasteclip/modules/explore/controllers/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(WatchFeedbackController());
    Get.lazyPut(() => UserController());
  }
}
