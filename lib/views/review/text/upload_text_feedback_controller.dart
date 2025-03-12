import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/views/review/text/model/text_feedback_model.dart';

class UploadTextFeedbackController extends GetxController {
  final textFeedback = TextEditingController();
  final rating = TextEditingController();

  Future<void> saveFeedback({
    required String restaurantName,
    required String branchName,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        return;
      }

      final String userId = user.uid;
      final feedback = FeedbackModel(
        userId: userId,
        feedbackText: textFeedback.text,
        rating: rating.text,
        createdAt: DateTime.now(),
      );

      final restaurantDoc = FirebaseFirestore.instance
          .collection('restaurants')
          .doc(restaurantName);

      final restaurantSnapshot = await restaurantDoc.get();
      if (!restaurantSnapshot.exists) {
        log("Restaurant does not exist!");
        return;
      }

      final List<dynamic> branches = restaurantSnapshot['branches'] ?? [];
      bool branchFound = false;

      for (var branch in branches) {
        if (branch['branchAddress'] == branchName) {
          branchFound = true;
          branch['textFeedback'] = (branch['textFeedback'] ?? [])
            ..add(feedback.toMap());
          break;
        }
      }

      if (branchFound) {
        await restaurantDoc.update({'branches': branches});
        log("Feedback submitted successfully!");
      } else {
        log("Branch not found!");
      }

      textFeedback.clear();
      rating.clear();
    } catch (e) {
      log("Error saving feedback: $e");
    }
  }
}
