import 'package:get/get.dart';
import 'package:tasteclip/views/auth/splash/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}
