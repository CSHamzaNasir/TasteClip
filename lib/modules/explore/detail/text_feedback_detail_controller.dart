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
import 'package:tasteclip/widgets/app_feild.dart';

class TextFeedbackDetailController extends GetxController {
  var isBookmarked = false.obs;
  var feedback = {}.obs;
  var comments = <Map<String, dynamic>>[].obs;

  void toggleBookmark() {
    isBookmarked.value = !isBookmarked.value;
  }

  void setFeedback(Map<String, dynamic> data) {
    feedback.value = data;
  }

  void showCommentsSheet(BuildContext context, String feedbackId) {
    fetchComments(feedbackId);

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                spacing: 6,
                children: [
                  Text("Comments",
                      style: AppTextStyles.bodyStyle.copyWith(
                          fontFamily: AppFonts.sandBold,
                          color: AppColors.textColor.withCustomOpacity(.8))),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        color: AppColors.greyColor, shape: BoxShape.circle),
                    child: Text("${comments.length}",
                        style: AppTextStyles.regularStyle
                            .copyWith(color: AppColors.mainColor)),
                  )
                ],
              ),
              SizedBox(height: 12),
              Expanded(
                child: Obx(() => ListView.builder(
                      itemCount: comments.length,
                      itemBuilder: (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          title: Text(comment['commentText'] ?? ""),
                          subtitle: Text(
                            "Posted by: ${comment['userId']}",
                            style: TextStyle(color: Colors.grey),
                          ),
                        );
                      },
                    )),
              ),
              32.vertical,
            ],
          ),
        ),
      ),
      isScrollControlled: true,
    );
  }

  void showAddCommentSheet(
    BuildContext context,
    String feedbackId,
  ) {
    final commentController = TextEditingController();

    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add a Comment",
                style: AppTextStyles.bodyStyle.copyWith(
                    fontFamily: AppFonts.sandBold,
                    color: AppColors.textColor.withCustomOpacity(.8))),
            SizedBox(height: 12),
            AppFeild(
              controller: commentController,
              hintText: "Write a comment...",
              hintTextColor: AppColors.primaryColor,
              feildFocusClr: true,
            ),
            SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () async {
                  if (commentController.text.isNotEmpty) {
                    await addCommentToFeedback(
                      feedbackId: feedbackId,
                      commentText: commentController.text,
                    );
                    commentController.clear();
                    fetchComments(feedbackId);
                    Get.back();
                  }
                },
                child: Text("Submit"),
              ),
            ),
            32.vertical,
          ],
        ),
      ),
      isScrollControlled: true,
    );
  }

  Future<void> fetchComments(String feedbackId) async {
    try {
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .get();

      if (feedbackDoc.exists) {
        final feedbackData = feedbackDoc.data() as Map<String, dynamic>;
        final commentsList = feedbackData['comments'] as List<dynamic>? ?? [];
        comments.assignAll(commentsList
            .map((comment) => comment as Map<String, dynamic>)
            .toList());
      }
    } catch (e) {
      log("Error fetching comments: $e");
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
                child: Text("Branch Detail",
                    style: AppTextStyles.bodyStyle
                        .copyWith(color: AppColors.mainColor))),
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
                      feedback['restaurantName'] ?? "No restaurant name",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                  ],
                )
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
                  )
                ],
              ),
            )
          ],
        ),
      ),
      isScrollControlled: false,
    );
  }
}
