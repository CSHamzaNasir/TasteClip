import 'package:get/get.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';
import 'package:tasteclip/data/models/auth_models.dart';

import '../../config/app_router.dart';

class UserProfileController extends GetxController {
  final AuthRepository authRepository;
  Rx<AuthModel?> user = Rx<AuthModel?>(null);

  UserProfileController({required this.authRepository});

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    user.value = await authRepository.fetchCurrentUserData();
  }

  void goToProfileDetailsScreen() {
    Get.toNamed(AppRouter.profileDetailScreen);
  }
}
