import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class UserFeedbackController extends GetxController {
  RxList<Map<String, dynamic>> userFeedbackList = <Map<String, dynamic>>[].obs;

  Future<void> fetchUserFeedback() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;

      if (user == null) {
        log("No user logged in");
        return;
      }

      String userId = user.uid; // Get the current user's ID
      log("Fetching feedback for user: $userId");

      final restaurants = await FirebaseFirestore.instance.collection('restaurants').get();

      List<Map<String, dynamic>> feedbacks = [];

      for (var restaurant in restaurants.docs) {
        List<dynamic> branches = restaurant['branches'] ?? [];

        for (var branch in branches) {
          List<dynamic> feedbackList = branch['textFeedback'] ?? [];

          for (var feedback in feedbackList) {
            if (feedback['user_id'] == userId) {
              feedbacks.add({
                'restaurant_name': restaurant.id,
                'branch_name': branch['branchAddress'],
                'feedback_text': feedback['feedback_text'],
                'rating': feedback['rating'],
                'created_at': feedback['created_at'],
              });
            }
          }
        }
      }

      userFeedbackList.assignAll(feedbacks);
      log("User feedback fetched successfully!");
    } catch (e) {
      log("Error fetching feedback: $e");
    }
  }
}
