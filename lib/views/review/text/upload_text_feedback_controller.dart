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
      final restaurantDoc = FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantName);

      final restaurantSnapshot = await restaurantDoc.get();
      if (!restaurantSnapshot.exists) {
        log("Restaurant does not exist!");
        return;
      }

      final List<dynamic> branches = restaurantSnapshot['branches'] ?? [];
      List<dynamic> updatedBranches = [];

      for (var branch in branches) {
        if (branch['branchAddress'] == branchName) {
          List<dynamic> existingFeedback = branch['textFeedback'] ?? [];
          existingFeedback.add({
            'feedback_text': textFeedback,
            'rating': rating,
            'created_at': DateTime.now().toIso8601String(),
          });
          branch['textFeedback'] = existingFeedback;
        }
        updatedBranches.add(branch);
      }

      await restaurantDoc.update({'branches': updatedBranches});
      log("Feedback submitted successfully!");
    } catch (e) {
      log("Error saving feedback: $e");
    }
  }
}
