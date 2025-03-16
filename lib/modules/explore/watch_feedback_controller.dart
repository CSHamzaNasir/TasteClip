import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class WatchFeedbackController extends GetxController {
  var feedbackList = <Map<String, dynamic>>[].obs;
  var feedbackListText = <Map<String, dynamic>>[].obs;
  var selectedIndex = 0.obs;
  var selectedTopFilter = 0.obs;
  var feedback = {}.obs;

  final List<String> categories = ["Text", "Image", "Videos"];
  final List<String> filters = ["All", "Breakfast", "Lunch", "Dinner"];

  void changeCategory(int index) {
    selectedIndex.value = index;
    if (categories[index] == "Text") {
      fetchFeedbackText();
    }
    if (categories[index] == "Image") {
      fetchImageFeedback();
    }
    log('Selected Category: ${categories[index]}');
  }

  void changeFilter(int index) {
    selectedTopFilter.value = index;
    fetchImageFeedback();
    fetchFeedbackText();
  }

  @override
  void onInit() {
    super.onInit();
    fetchImageFeedback();
    fetchFeedbackText();
  }

  Future<void> fetchImageFeedback() async {
    try {
      String selectedMealType = filters[selectedTopFilter.value];

      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedback = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) =>
              feedbackData['category'] == "image_feedback" &&
              (selectedMealType == "All" ||
                  feedbackData['mealType'] == selectedMealType))
          .map((feedbackData) {
        DateTime createdAt = feedbackData['createdAt'].toDate();
        return {
          "feedbackId": feedbackData['feedbackId'],
          "branch": feedbackData['branchName'],
          "restaurantName": feedbackData['restaurantName'],
          "branchThumbnail": feedbackData['branchThumbnail'],
          "image_title": feedbackData['imageTitle'],
          "description": feedbackData['description'],
          "imageUrl": feedbackData['imageUrl'],
          "rating": feedbackData['rating'].toString(),
          "created_at": timeago.format(createdAt),
          "meal_type": feedbackData['mealType'],
        };
      }).toList();

      feedbackList.assignAll(allFeedback);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch image feedback: $e");
    }
  }

  Future<void> fetchFeedbackText() async {
    try {
      String selectedMealType = filters[selectedTopFilter.value];

      QuerySnapshot feedbackQuery = await FirebaseFirestore.instance
          .collection('feedback')
          .orderBy('createdAt', descending: true)
          .get();

      List<Map<String, dynamic>> allFeedbackText = feedbackQuery.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .where((feedbackData) =>
              feedbackData['category'] == "text_feedback" &&
              (selectedMealType == "All" ||
                  feedbackData['mealType'] == selectedMealType))
          .map((feedbackData) {
        DateTime createdAt = feedbackData['createdAt'].toDate();
        return {
          "feedbackId": feedbackData['feedbackId'],
          "branch": feedbackData['branchName'],
          "branchThumbnail": feedbackData['branchThumbnail'],
          "review": feedbackData['review'],
          "rating": feedbackData['rating'].toString(),
          "created_at": timeago.format(createdAt),
          "meal_type": feedbackData['mealType'],
        };
      }).toList();

      feedbackListText.assignAll(allFeedbackText);
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch text feedback: $e");
    }
  }

  Future<void> addCommentToFeedback({
    required String feedbackId,
    required String commentText,
  }) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        return;
      }

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc(feedbackId);

      await feedbackDoc.update({
        'comments': FieldValue.arrayUnion([
          {
            'userId': user.uid,
            'commentText': commentText,
            'timestamp': DateTime.now(),
          }
        ]),
      });

      log("Comment added successfully!");
    } catch (e) {
      log("Error adding comment: $e");
    }
  }

  void showRestaurantSheet(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16).copyWith(bottom: 40),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                "Branch Detail",
                style: AppTextStyles.bodyStyle
                    .copyWith(color: AppColors.mainColor),
              ),
            ),
            Row(
              spacing: 16,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: (feedback['branchThumbnail'] != null &&
                          feedback['branchThumbnail'].isNotEmpty)
                      ? NetworkImage(feedback['branchThumbnail'])
                      : null,
                  child: (feedback['branchThumbnail'] == null ||
                          feedback['branchThumbnail'].isEmpty)
                      ? Icon(Icons.image_not_supported, size: 25)
                      : null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feedback['branch'] ?? "No branch",
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                    Text(
                      feedback['channelName'] ?? "No Channel Name",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Text(
              "Total Feedback: 23",
              style: AppTextStyles.bodyStyle.copyWith(
                color: AppColors.textColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: AppColors.primaryColor),
                color: AppColors.mainColor.withCustomOpacity(.1),
              ),
              child: Row(
                children: [
                  Text(
                    "Channel profile",
                    style: AppTextStyles.bodyStyle.copyWith(
                      fontFamily: AppFonts.sandSemiBold,
                      color: AppColors.mainColor,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(
                    AppAssets.arrowNext,
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                      AppColors.mainColor,
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      isScrollControlled: false,
    );
  }

  Future<Map<String, dynamic>> fetchFeedback(String feedbackId) async {
    try {
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .get();

      if (feedbackDoc.exists) {
        return feedbackDoc.data() as Map<String, dynamic>;
      } else {
        log("Feedback not found!");
        return {};
      }
    } catch (e) {
      log("Error fetching feedback: $e");
      return {};
    }
  }
}
