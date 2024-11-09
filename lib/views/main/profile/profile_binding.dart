import 'package:get/get.dart';
import 'package:tasteclip/data/repositories/auth_repository_impl.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';
import 'package:tasteclip/views/main/profile/user_profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl());
    Get.lazyPut<UserProfileController>(() => UserProfileController(
          authRepository: Get.find(),
        ));
  }
}
