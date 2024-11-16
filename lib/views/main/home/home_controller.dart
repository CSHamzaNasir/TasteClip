import 'dart:developer';

import 'package:get/get.dart';

import '../../../data/models/auth_models.dart';
import '../../../domain/repositories/auth_repository.dart';

class HomeController extends GetxController {
  final AuthRepository authRepository;

  HomeController({required this.authRepository});

  Rx<AuthModel?> user = Rx<AuthModel?>(null);

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      final fetchedUser = await authRepository.fetchCurrentUserData();
      user.value = fetchedUser;
    } catch (e) {
      log('Error fetching user data: $e');
    }
  }
}
