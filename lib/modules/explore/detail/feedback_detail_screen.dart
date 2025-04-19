import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final UploadFeedbackModel feedback;

  const FeedbackDetailScreen({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
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
              child: feedback.category == 'image_feedback' &&
                      feedback.mediaUrl != null
                  ? CachedNetworkImage(
                      imageUrl: feedback.mediaUrl!,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Center(child: CircularProgressIndicator()),
                      errorWidget: (context, url, error) =>
                          const Center(child: Icon(Icons.error)),
                    )
                  : SizedBox.shrink()),
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
                      Divider(color: AppColors.textColor),
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
                      Spacer(),
                      // GestureDetector(
                      //   onTap: () => controller.showAddCommentSheet(
                      //       context, feedback['feedbackId']),
                      //   child: Row(
                      //     children: [
                      //       Icon(Icons.add, color: AppColors.mainColor),
                      //       SizedBox(width: 4),
                      //       Text(
                      //         "Add comment",
                      //         style: AppTextStyles.lightStyle.copyWith(
                      //           color: AppColors.mainColor,
                      //           fontFamily: AppFonts.sandBold,
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Spacer(),
                      // GestureDetector(
                      //   onTap: () => controller.showCommentsSheet(
                      //       context, feedback['feedbackId']),
                      //   child: Obx(
                      //     () => Row(
                      //       children: [
                      //         Icon(Icons.comment_outlined,
                      //             color: AppColors.mainColor),
                      //         SizedBox(width: 4),
                      //         Text(
                      //           "${controller.comments.length}",
                      //           style: AppTextStyles.lightStyle.copyWith(
                      //             color: AppColors.mainColor,
                      //           ),
                      //         ),
                      //       ],
                      //     ),
                      //   ),
                      // ),
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
