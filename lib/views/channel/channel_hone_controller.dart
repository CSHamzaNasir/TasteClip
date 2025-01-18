import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tasteclip/utils/app_string.dart';

class ChannelHomeController extends GetxController {
  int selectedIndex = 0;
  final List<String> labels = [AppString.videos, "Text", "Images"];

  void updateIndex(int index) {
    selectedIndex = index;
    update();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxString restaurantName = ''.obs;
  RxString branchAddress = ''.obs;

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
          restaurantName.value = managerDoc['restaurant_name'] ?? '';
          branchAddress.value = managerDoc['branch_address'] ?? '';
        }
      }
    } catch (e) {
      log('Error fetching manager data: $e');
    }
  }
}
