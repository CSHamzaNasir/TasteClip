import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

class RestaurantListController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  var approvedManagers = <QueryDocumentSnapshot>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchApprovedManagers();
  }

  void fetchApprovedManagers() {
    _firestore
        .collection('manager_credentials')
        .where('status', isEqualTo: 1)
        .snapshots()
        .listen((snapshot) {
      approvedManagers.value = snapshot.docs;
    });
  }

  void showFeedbackDialog(String restaurantName) {
    List<Map<String, dynamic>> feedbackOptions = [
      {'icon': AppAssets.message, 'label': "Text"},
      {'icon': AppAssets.camera, 'label': "Image"},
      {'icon': AppAssets.video, 'label': "Video"},
    ];

    Get.dialog(
      Dialog(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 300),
          child: Padding(
            padding: const EdgeInsets.all(8.0).copyWith(bottom: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'Select Feedback Option',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
                12.vertical,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: feedbackOptions.map((option) {
                    return Column(
                      children: [
                        SvgPicture.asset(option['icon'], width: 24, height: 24),
                        8.vertical,
                        Text(option['label']),
                      ],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
