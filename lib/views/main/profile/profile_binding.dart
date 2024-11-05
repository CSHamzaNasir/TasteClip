import 'package:get/get.dart';
import 'package:tasteclip/data/repositories/auth_repository_impl.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';
import 'package:tasteclip/views/main/profile/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<ProfileController>(() => ProfileController(
          authRepository: Get.find(),
        ));
  }
}
