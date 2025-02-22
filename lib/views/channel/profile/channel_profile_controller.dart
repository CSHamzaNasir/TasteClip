import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_router.dart';

import '../../../config/app_assets.dart';
import '../../../utils/app_alert.dart';

class ChannelProfileController extends GetxController {
  List<Map<String, dynamic>> feedbackOptions = [
    {'icon': AppAssets.message, 'label': "Text"},
    {'icon': AppAssets.camera, 'label': "Image"},
    {'icon': AppAssets.video, 'label': "Video"},
  ];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  var managerData = Rxn<Map<String, dynamic>>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchManagerData();
  }

  Future<void> fetchManagerData() async {
    try {
      User? user = auth.currentUser;
      if (user == null) return;

      QuerySnapshot restaurantQuery =
          await firestore.collection('restaurants').get();

      for (var doc in restaurantQuery.docs) {
        List<dynamic> branches = doc['branches'];
        for (var branch in branches) {
          if (branch['branchId'] == user.uid) {
            managerData.value = {
              'restaurantName': doc.id,
              'branchEmail': branch['branchEmail'],
              'branchAddress': branch['branchAddress'],
              'status': branch['status'],
            };
            isLoading.value = false;
            return;
          }
        }
      }
      isLoading.value = false;
      AppAlerts.showSnackbar(
        isSuccess: false,
        message: "Manager data not found. Please contact support.",
      );
    } catch (e) {
      isLoading.value = false;
      AppAlerts.showSnackbar(isSuccess: false, message: e.toString());
    }
  }

  void goToAllRegisterScreen() {
    Get.toNamed(AppRouter.channelProfileEditScreen);
  }
}
