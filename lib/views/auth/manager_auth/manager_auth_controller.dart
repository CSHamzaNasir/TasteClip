import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/utils/app_alert.dart';

class ManagerAuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;

  // Fields controllers
  final formKey = GlobalKey<FormState>();
  final businessEmailController = TextEditingController();
  final passkeyController = TextEditingController();
  final restaurantNameController = TextEditingController();
  final branchAddressController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    businessEmailController.dispose();
    passkeyController.dispose();
    restaurantNameController.dispose();
    branchAddressController.dispose();
  }

  Future<void> registerManager() async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: businessEmailController.text.trim(),
        password: passkeyController.text.trim(),
      );
      AppAlerts.showSnackbar(
          isSuccess: true, message: "Succesfully registered");
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }
  Future<void> loginManager() async {
    try {
      await auth.signInWithEmailAndPassword(
        email: businessEmailController.text.trim(),
        password: passkeyController.text.trim(),
      );
      AppAlerts.showSnackbar(
          isSuccess: true, message: "Succesfully Login");
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }

  void goToRegisterScreen() {
    Get.toNamed(AppRouter.managerRegisterScreen);
  }

  void goToLoginScreen() {
    Get.toNamed(AppRouter.managerLoginScreen);
  }
}
