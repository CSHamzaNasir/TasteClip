import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/explore/detail/text_feedback_detail_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import '../watch_feedback_controller.dart';

class TextFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;
  final String? branchName;
  final bool showBranchName;

  TextFeedbackDisplay({
    super.key,
    required this.controller,
    required this.category,
    this.branchName,
    this.showBranchName = true,
  });

  final WatchFeedbackController controller;
  final textfeedbackController = Get.put(TextFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final displayedFeedback = branchName != null
          ? controller.feedbackListText
              .where((feedback) => feedback['branch'] == branchName)
              .toList()
          : controller.feedbackListText;

      if (displayedFeedback.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.feedback_outlined,
                size: 48,
                color: AppColors.btnUnSelectColor,
              ),
              16.vertical,
              Text(
                'No feedback available',
                style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.btnUnSelectColor,
                ),
              ),
            ],
          ),
        );
      }

      if (controller.feedbackListText.isEmpty) {
        return ListView.separated(
          itemCount: 5,
          separatorBuilder: (context, index) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Divider(
              color: AppColors.btnUnSelectColor,
            ),
          ),
          itemBuilder: (context, index) {
            return const TextFeedbackShimmer();
          },
        );
      }

      return ListView.separated(
        itemCount: displayedFeedback.length,
        separatorBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Divider(
            color: AppColors.btnUnSelectColor,
          ),
        ),
        itemBuilder: (context, index) {
          final feedbackText = displayedFeedback[index];

          return GestureDetector(
            onTap: () {},
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    ProfileImageWithShimmer(
                      imageUrl: feedbackText['user_profileImage'],
                      radius: 18,
                    ),
                    12.horizontal,
                    Text(
                      feedbackText['user_fullName'] ?? "Unknown User",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                  ],
                ),
                12.vertical,
                Text(
                  feedbackText['review'] ?? "No feedback available",
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.textColor.withCustomOpacity(.6),
                  ),
                ),
                12.vertical,
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        controller.toggleLikeFeedback(
                          feedbackText['feedbackId'],
                          feedbackText,
                        );
                      },
                      child: Icon(
                        controller.hasUserLikedFeedback(feedbackText)
                            ? Icons.favorite
                            : Icons.favorite_border_outlined,
                        color: AppColors.mainColor,
                        size: 20,
                      ),
                    ),
                    4.horizontal,
                    Text(
                      '${feedbackText['likes']?.length ?? 0}',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    12.horizontal,
                    Container(
                      color: AppColors.mainColor.withCustomOpacity(.4),
                      height: 20,
                      width: 1,
                    ),
                    12.horizontal,
                    GestureDetector(
                      onTap: () {
                        textfeedbackController.showAddCommentSheet(
                          context,
                          feedbackText['feedbackId'],
                        );
                      },
                      child: Text(
                        "Reply",
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      ),
                    ),
                    12.horizontal,
                    Container(
                      color: AppColors.mainColor.withCustomOpacity(.4),
                      height: 20,
                      width: 1,
                    ),
                    12.horizontal,
                    Text(
                      feedbackText['created_at'] ?? "",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.btnUnSelectColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                    if (showBranchName && feedbackText['branch'] != null) ...[
                      12.horizontal,
                      Text(
                        feedbackText['branch'],
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.btnUnSelectColor,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      ),
                    ],
                  ],
                ),
              ],
            ),
          );
        },
      );
    });
  }
}
