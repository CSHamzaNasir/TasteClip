import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UploadTextFeedbackController extends GetxController {
  final textFeedback = TextEditingController();
  final rating = TextEditingController();

  Future<void> saveFeedback({
    required String textFeedback,
    required String rating,
    required String restaurantName,
    required String branchName,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('text_feedback').add({
        'text_feedback': textFeedback,
        'rating': rating,
        'restaurant_name': restaurantName,
        'branch_name': branchName,
        'created_at': FieldValue.serverTimestamp(),
      });

      log("Feedback submitted successfully!");
    } catch (e) {
      log("Error saving feedback: $e");
    }
  }
}
