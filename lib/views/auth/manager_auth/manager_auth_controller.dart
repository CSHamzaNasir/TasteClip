import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/utils/app_alert.dart';
import 'package:tasteclip/views/channel/channel_home_screen.dart';

class ManagerAuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

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
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: businessEmailController.text.trim(),
        password: passkeyController.text.trim(),
      );

      await firestore
          .collection('manager_credentials')
          .doc(userCredential.user!.uid)
          .set({
        'email': businessEmailController.text.trim(),
        'restaurant_name': restaurantNameController.text.trim(),
        'branch_address': branchAddressController.text.trim(),
        'status': 0,
        'created_at': FieldValue.serverTimestamp(),
      });

      AppAlerts.showSnackbar(
          isSuccess: true,
          message: "Successfully registered. Awaiting approval.");
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }

  Future<void> loginManager() async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: businessEmailController.text.trim(),
        password: passkeyController.text.trim(),
      );

      DocumentSnapshot managerDoc = await firestore
          .collection('manager_credentials')
          .doc(userCredential.user!.uid)
          .get();

      if (managerDoc.exists && managerDoc['status'] == 1) {
        Get.to(ChannelHomeScreen());
        AppAlerts.showSnackbar(
            isSuccess: true, message: "Successfully Logged In");
      } else {
        AppAlerts.showSnackbar(
            isSuccess: false,
            message: "Account not approved. Please contact admin.");
        auth.signOut();
      }
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
