import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/data/models/auth_models.dart';
import 'package:tasteclip/data/repositories/auth_repository_impl.dart';
import 'package:tasteclip/domain/repositories/auth_repository.dart';

import '../../utils/app_alert.dart'; // Import AppAlerts

class AuthController extends GetxController {
  final AuthRepository _authRepository = AuthRepositoryImpl();

  final fullNameController = TextEditingController();
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  // Registration function
  void register() async {
    if (fullNameController.text.isEmpty ||
        userNameController.text.isEmpty ||
        emailController.text.isEmpty ||
        passwordController.text.isEmpty) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Please fill all fields");
      return;
    }

    if (!RegExp(r"^[a-zA-Z]").hasMatch(fullNameController.text)) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Full name must start with a letter");
      return;
    }

    if (!RegExp(r"^[a-zA-Z0-9_]{3,15}$").hasMatch(userNameController.text)) {
      AppAlerts.showSnackbar(
          isSuccess: false,
          message: "Username must be 3-15 characters with no special symbols");
      return;
    }

    if (!RegExp(r"^[\w-\.]+@(gmail|mail)\.com$")
        .hasMatch(emailController.text)) {
      AppAlerts.showSnackbar(
          isSuccess: false,
          message: "Invalid email format. Use @gmail.com or @mail.com");
      return;
    }

    if (passwordController.text.length < 6) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Password must be at least 6 characters");
      return;
    }

    try {
      isLoading = true;
      update();

      final user = await _authRepository.createUserWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        final authModel = AuthModel(
          uid: user.uid,
          fullName: fullNameController.text.trim(),
          userName: userNameController.text.trim(),
          email: emailController.text.trim(),
        );
        await _authRepository.storeUserDataFirestore(authModel);
        AppAlerts.showSnackbar(
            isSuccess: true, message: "Registration successful!");
        goToLoginScreen();
      } else {
        AppAlerts.showSnackbar(
            isSuccess: false, message: "Registration failed. Try again.");
      }
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Error: ${e.toString()}");
    } finally {
      isLoading = false;
      update();
    }
  }

// Login function
  void login() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Please enter email and password");
      return;
    }

    try {
      isLoading = true;
      update();
      final user = await _authRepository.loginUserWithEmail(
        emailController.text.trim(),
        passwordController.text.trim(),
      );

      if (user != null) {
        AppAlerts.showSnackbar(isSuccess: true, message: "Login successful!");
      } else {
        AppAlerts.showSnackbar(
            isSuccess: false, message: "The Email and Password is not match");
      }
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Error: ${e.toString()}");
    } finally {
      isLoading = false;
      update();
    }
  }

  // Navigation functions
  void goToLoginScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToPhoneVerifyScreen() {
    Get.toNamed(AppRouter.phoneAuthScreen);
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRouter.registerScreen);
  }

  @override
  void onClose() {
    fullNameController.dispose();
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
