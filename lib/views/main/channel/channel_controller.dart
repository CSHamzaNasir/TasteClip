import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'channel_data.dart';

class ChannelController extends GetxController {
  final restaurantNameController = TextEditingController();
  final branchNameController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveChannelData() async {
    try {
      String restaurantName = restaurantNameController.text.trim();
      String branchName = branchNameController.text.trim();

      if (restaurantName.isNotEmpty && branchName.isNotEmpty) {
        ChannelData channelData = ChannelData(
          restaurantName: restaurantName,
          branchName: branchName,
        );

        await _firestore.collection('channel-data').add(channelData.toMap());
        log('Data saved successfully!');
      } else {
        log('Please fill in both fields');
      }
    } catch (e) {
      log('Error saving data: $e');
    }
  }
}
