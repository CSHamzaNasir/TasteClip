import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/modules/auth/manager_auth/screens/manager_approval_screen.dart';
import 'package:tasteclip/modules/channel/screens/channel_home_screen.dart';
import 'package:tasteclip/utils/app_alert.dart';

class ManagerAuthController extends GetxController {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;

  final formKey = GlobalKey<FormState>();
  final businessEmailController = TextEditingController();
  final passkeyController = TextEditingController();
  final restaurantNameController = TextEditingController();
  final branchAddressController = TextEditingController();

  var isLoading = false.obs;
  var currentBranchBill = ''.obs;
  XFile? selectedBillImage;

  @override
  void onInit() {
    super.onInit();
    fetchCurrentBranchData();
  }

  @override
  void dispose() {
    super.dispose();
    businessEmailController.dispose();
    passkeyController.dispose();
    restaurantNameController.dispose();
    branchAddressController.dispose();
  }

  Future<void> fetchCurrentBranchData() async {
    try {
      isLoading.value = true;
      String userId = auth.currentUser?.uid ?? '';
      if (userId.isEmpty) return;

      String? restaurantName;
      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == userId) {
            restaurantName = doc.id;
            currentBranchBill.value = branch['branchBill'] ?? '';
            break;
          }
        }
        if (restaurantName != null) break;
      }
    } catch (e) {
      AppAlerts.showSnackbar(
          isSuccess: false, message: 'Failed to fetch branch data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> pickBillImage(ImageSource source) async {
    try {
      final pickedFile = await ImagePicker().pickImage(source: source);
      if (pickedFile != null) {
        selectedBillImage = pickedFile;
        currentBranchBill.value = pickedFile.path;
      }
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: 'Failed to pick image');
    }
  }

  Future<void> updateBranchBill() async {
    try {
      if (selectedBillImage == null) return;

      isLoading.value = true;
      String userId = auth.currentUser?.uid ?? '';
      if (userId.isEmpty) throw Exception('User not logged in');

      String filePath =
          'branch_bills/$userId/${DateTime.now().millisecondsSinceEpoch}';
      File imageFile = File(selectedBillImage!.path);
      TaskSnapshot uploadTask = await storage.ref(filePath).putFile(imageFile);
      String downloadUrl = await uploadTask.ref.getDownloadURL();

      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();
      bool updated = false;

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (int i = 0; i < branches.length; i++) {
          if (branches[i]['branchId'] == userId) {
            Map<String, dynamic> updatedBranch =
                Map<String, dynamic>.from(branches[i]);
            updatedBranch['branchBill'] = downloadUrl;

            List<dynamic> updatedBranches = List.from(branches);
            updatedBranches[i] = updatedBranch;

            await firestore.collection('restaurants').doc(doc.id).update({
              'branches': updatedBranches,
            });

            currentBranchBill.value = downloadUrl;
            selectedBillImage = null;
            updated = true;
            break;
          }
        }
        if (updated) break;
      }

      if (!updated) {
        throw Exception('Branch not found');
      }

      AppAlerts.showSnackbar(
          isSuccess: true, message: 'Bill updated successfully');
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> registerManager() async {
    try {
      isLoading.value = true;
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
        "branchBill": "",
        "channelName": "",
        "rejectionMessage": "",
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
        Get.off(() => ManagerApprovalScreen(
              status: ManagerApprovalStatus.pending,
            ));
      }
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loginManager() async {
    try {
      isLoading.value = true;

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

      int status = branchData['status'] ?? 0;

      if (status == 0) {
        Get.off(() => ManagerApprovalScreen(
              status: ManagerApprovalStatus.pending,
            ));
        return;
      } else if (status == 2) {
        Get.off(() => ManagerApprovalScreen(
              status: ManagerApprovalStatus.rejected,
            ));
        return;
      }

      Get.off(() => ChannelHomeScreen());
      AppAlerts.showSnackbar(
        isSuccess: true,
        message: "Successfully Logged In",
      );
    } catch (e) {
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    } finally {
      isLoading.value = false;
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
