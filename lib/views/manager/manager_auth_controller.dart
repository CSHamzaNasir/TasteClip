import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/data/models/manager_auth_model.dart';
import 'package:tasteclip/data/repositories/manager_repository_impl.dart';
import 'package:tasteclip/domain/repositories/manager_auth_repository.dart';

import '../../utils/app_alert.dart';

class ManagerAuthController extends GetxController {
//

  final ManagerAuthRepository _mangerAuthRepository = ManagerRepositoryImpl();

  final restaurantNameController = TextEditingController();
  final addressController = TextEditingController();
  final emailController = TextEditingController();
  final businessEmailController = TextEditingController();
  final passkeyController = TextEditingController();

  bool isLoading = false;

  void register() async {
    if (restaurantNameController.text.isEmpty ||
        addressController.text.isEmpty ||
        businessEmailController.text.isEmpty ||
        passkeyController.text.isEmpty) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Please fill all fields");
      return;
    }

    if (!RegExp(r"^[a-zA-Z]").hasMatch(restaurantNameController.text)) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Full name must start with a letter");
      return;
    }

    if (!RegExp(r"^[\w-\.]+@(gmail|mail)\.com$")
        .hasMatch(businessEmailController.text)) {
      AppAlerts.showSnackbar(
          isSuccess: false,
          message: "Invalid email format. Use @gmail.com or @mail.com");
      return;
    }

    if (passkeyController.text.length < 6) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: "Password must be at least 6 characters");
      return;
    }

    try {
      isLoading = true;
      update();

      final user = await _mangerAuthRepository.createManagerWithEmail(
        businessEmailController.text.trim(),
        passkeyController.text.trim(),
      );

      if (user != null) {
        final managerAuthModel = ManagerAuthModel(
          uid: user.uid,
          restaurantName: restaurantNameController.text.trim(),
          address: addressController.text.trim(),
          businessEmail: businessEmailController.text.trim(),
          passkey: passkeyController.text.trim(),
        );
        await _mangerAuthRepository.storeManagerDataFirestore(managerAuthModel);
        AppAlerts.showSnackbar(
            isSuccess: true, message: "Registration successful!");
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

  void goToUserScreen() {
    Get.toNamed(AppRouter.loginScreen);
  }

  void goToChannelLogionScreen() {
    Get.toNamed(AppRouter.channelLoginScreen);
  }

  void goToChannelRegisterScreen() {
    Get.toNamed(AppRouter.channelRegisterScreen);
  }
}
