import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/components/branch_detail_sheet.dart';
import 'package:tasteclip/widgets/app_feild.dart';

class ImageFeedbackDetailController extends GetxController {
  var isBookmarked = false.obs;
  var feedback = {}.obs;
  var comments = <Map<String, dynamic>>[].obs;
  var likes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  @override
  void onReady() {
    super.onReady();
    fetchData();
  }

  void fetchData() async {
    if (feedback.isNotEmpty) {
      await fetchLikes(feedback['feedbackId']);
      await fetchComments(feedback['feedbackId']);
    }
  }

  Future<void> toggleLike(String feedbackId) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        log("User not logged in!");
        return;
      }

      final feedbackDoc =
          FirebaseFirestore.instance.collection('feedback').doc(feedbackId);

      if (likes.contains(user.uid)) {
        await feedbackDoc.update({
          'likes': FieldValue.arrayRemove([user.uid]),
        });
        likes.remove(user.uid);
      } else {
        await feedbackDoc.update({
          'likes': FieldValue.arrayUnion([user.uid]),
        });
        likes.add(user.uid);
      }

      log("Like toggled successfully!");
    } catch (e) {
      log("Error toggling like: $e");
    }
  }

  void setFeedback(Map<String, dynamic> data) async {
    feedback.value = data;
    await fetchLikes(data['feedbackId']);
    await fetchComments(data['feedbackId']);
  }

  Future<void> fetchLikes(String feedbackId) async {
    try {
      final feedbackDoc = await FirebaseFirestore.instance
          .collection('feedback')
          .doc(feedbackId)
          .get();

      if (feedbackDoc.exists) {
        final feedbackData = feedbackDoc.data() as Map<String, dynamic>;
        final likesList = feedbackData['likes'] as List<dynamic>? ?? [];
        likes.assignAll(likesList.cast<String>());
      }
    } catch (e) {
      log("Error fetching likes: $e");
    }
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
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: AppColors.btnUnSelectColor
                                    .withCustomOpacity(.3)),
                            child: ListTile(
                              title: Text(comment['commentText'] ?? "",
                                  style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.mainColor,
                                      fontFamily: AppFonts.sandBold)),
                              subtitle: Text(
                                "Posted by: Hamza Nasir",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
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

  void showAddCommentSheet(BuildContext context, String feedbackId) {
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
        child: BranchDetail(feedback: feedback),
      ),
      isScrollControlled: false,
    );
  }
}
