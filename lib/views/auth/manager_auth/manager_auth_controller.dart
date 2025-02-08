import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/utils/app_alert.dart';

import '../../channel/profile/channel_profile_screen.dart';

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

      String restaurantName =
          restaurantNameController.text.trim().toLowerCase();

      Map<String, dynamic> branchData = {
        "branchId": userCredential.user!.uid,
        "branchEmail": businessEmailController.text.trim(),
        "branchAddress": branchAddressController.text.trim(),
        "status": 0,
        "branchThumbnail": "",
        "channelName": "",
        "createdAt": DateTime.now(),
      };

      DocumentSnapshot restaurantDoc =
          await firestore.collection('restaurants').doc(restaurantName).get();

      if (restaurantDoc.exists) {
        await firestore.collection('restaurants').doc(restaurantName).update({
          "branches": FieldValue.arrayUnion([branchData])
        });

        AppAlerts.showSnackbar(
          isSuccess: true,
          message: "New branch added to existing restaurant.",
        );
      } else {
        await firestore.collection('restaurants').doc(restaurantName).set({
          "restaurantId": userCredential.user!.uid,
          "restaurantName": restaurantNameController.text.trim(),
          "branches": [branchData],
        });

        AppAlerts.showSnackbar(
          isSuccess: true,
          message: "Successfully registered. Awaiting approval.",
        );
      }
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

      String userId = userCredential.user!.uid;
      String? restaurantName;

      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == userId) {
            restaurantName = doc.id;
            break;
          }
        }
        if (restaurantName != null) break;
      }

      if (restaurantName == null) {
        AppAlerts.showSnackbar(
          isSuccess: false,
          message: "Branch data not found. Please contact support.",
        );
        auth.signOut();
        return;
      }

      DocumentSnapshot restaurantDoc =
          await firestore.collection('restaurants').doc(restaurantName).get();

      List<dynamic> branches = restaurantDoc['branches'];
      Map<String, dynamic>? branchData;

      for (var branch in branches) {
        if (branch['branchId'] == userId) {
          branchData = branch;
          break;
        }
      }

      if (branchData == null) {
        AppAlerts.showSnackbar(
          isSuccess: false,
          message: "Branch details not found. Please contact admin.",
        );
        auth.signOut();
        return;
      }

      Get.to(() => ChannelProfileScreen(), arguments: {
        "restaurantName": restaurantDoc['restaurantName'],
        "branchEmail": branchData['branchEmail'],
        "branchAddress": branchData['branchAddress'],
        "channelName": branchData['channelName'],
      });

      AppAlerts.showSnackbar(
        isSuccess: true,
        message: "Successfully Logged In",
      );
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }

  void goToRegisterScreen() {
    Get.delete<ManagerAuthController>();
    Get.toNamed(AppRouter.managerRegisterScreen);
  }

  void goToLoginScreen() {
    Get.delete<ManagerAuthController>();
    Get.toNamed(AppRouter.managerLoginScreen);
  }
}
