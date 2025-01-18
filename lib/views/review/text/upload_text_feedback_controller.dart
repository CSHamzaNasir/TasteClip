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
          .collection('feedbacks')
          .doc(restaurantName);

      await restaurantDoc.set({
        'restaurant_name': restaurantName,
      }, SetOptions(merge: true));

      final branchDoc = restaurantDoc.collection('branches').doc(branchName);

      await branchDoc.set({
        'branch_name': branchName,
      }, SetOptions(merge: true));

      final branchSnapshot = await branchDoc.get();
      final List<dynamic> existingFeedback =
          branchSnapshot.data()?['text_feedback'] ?? [];

      existingFeedback.add({
        'feedback_text': textFeedback,
        'rating': rating,
        'created_at': DateTime.now().toIso8601String(),
      });

      await branchDoc.update({
        'text_feedback': existingFeedback,
      });

      log("Feedback submitted successfully!");
    } catch (e) {
      log("Error saving feedback: $e");
    }
  }
}
