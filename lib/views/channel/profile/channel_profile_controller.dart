import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

class ChannelProfileController extends GetxController {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString email = ''.obs;
  RxString channelName = ''.obs;
  RxString profileImage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManagerData();
  }

  Future<void> fetchManagerData() async {
    try {
      final user = auth.currentUser;
      if (user != null) {
        final managerDoc = await firestore
            .collection('manager_credentials')
            .doc(user.uid)
            .get();

        if (managerDoc.exists) {
          email.value = managerDoc['email'] ?? '';
          channelName.value = managerDoc['channel_name'] ?? '';
          profileImage.value = managerDoc['profile_image'] ?? '';
        }
      }
    } catch (e) {
      log('Error fetching manager data: $e');
    }
  }

  void goToRoleScreen() {
    Get.toNamed(AppRouter.roleScreen);
  }

  void goToEditScreen() {
    Get.toNamed(AppRouter.channelProfileEditScreen);
  }
}
