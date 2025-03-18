import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/image_feedback_detail_controller.dart';
import 'package:tasteclip/widgets/app_button.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final Map<String, dynamic> feedback;

  FeedbackDetailScreen({super.key, required this.feedback});

  final controller = Get.put(ImageFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    controller.setFeedback(feedback);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Feedback Details",
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child:
                feedback['imageUrl'] != null && feedback['imageUrl'].isNotEmpty
                    ? Image.network(
                        feedback['imageUrl'],
                        fit: BoxFit.cover,
                      )
                    : Container(color: Colors.grey),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withCustomOpacity(0.6),
                  Colors.black.withCustomOpacity(0.3),
                  Colors.black.withCustomOpacity(0.6),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Spacer(),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.circular(32),
                  ),
                  child: Column(
                    spacing: 12,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              feedback['branch'] ?? "No Title",
                              style: AppTextStyles.headingStyle1.copyWith(
                                color: AppColors.textColor,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Icon(
                            Icons.star,
                            size: 16,
                            color: Colors.amber,
                          ),
                          Text(
                            feedback['rating'] ?? "0.0",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ],
                      ),
                      Divider(color: AppColors.textColor),
                      Text(
                        feedback['description'] ?? "No Description",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(Icons.access_time, size: 18, color: Colors.grey),
                          SizedBox(width: 6),
                          Text(
                            feedback['created_at']?.toString() ??
                                "Unknown Date",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.textColor.withCustomOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Obx(
                        () => AppButton(
                          text: controller.isBookmarked.value
                              ? "Bookmarked"
                              : "Add to bookmark",
                          onPressed: () {},
                          btnRadius: 50,
                        ),
                      ),
                    ],
                  ),
                ),
                16.vertical,
                Container(
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.whiteColor,
                  ),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () =>
                            controller.toggleLike(feedback['feedbackId']),
                        child: Obx(
                          () => Row(
                            children: [
                              Icon(
                                controller.likes.contains(
                                        FirebaseAuth.instance.currentUser?.uid)
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: AppColors.mainColor,
                              ),
                              SizedBox(width: 4),
                              Text(
                                "${controller.likes.length}",
                                style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => controller.showAddCommentSheet(
                            context, feedback['feedbackId']),
                        child: Row(
                          children: [
                            Icon(Icons.add, color: AppColors.mainColor),
                            SizedBox(width: 4),
                            Text(
                              "Add comment",
                              style: AppTextStyles.lightStyle.copyWith(
                                color: AppColors.mainColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () => controller.showCommentsSheet(
                            context, feedback['feedbackId']),
                        child: Obx(
                          () => Row(
                            children: [
                              Icon(Icons.comment_outlined,
                                  color: AppColors.mainColor),
                              SizedBox(width: 4),
                              Text(
                                "${controller.comments.length}",
                                style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                12.vertical,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
