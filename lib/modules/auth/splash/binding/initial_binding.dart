import 'package:get/get.dart';
import 'package:tasteclip/modules/auth/splash/controller/local_user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController(), permanent: true);
  }
}
