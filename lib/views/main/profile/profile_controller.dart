import 'package:get/get.dart';
import 'package:tasteclip/data/models/auth_models.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';

class ProfileController extends GetxController {
  var currentUserData = Rx<AuthModel?>(null);
  var isLoading = false.obs;

  ProfileController({required this.authRepository});

  final AuthRepository authRepository;
  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      isLoading.value = true;
      currentUserData.value = await authRepository.fetchCurrentUserData();
    } finally {
      isLoading.value = false;
    }
  }
}
