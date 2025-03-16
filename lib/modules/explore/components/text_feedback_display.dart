import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/detail/text_feedback_detail_controller.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_colors.dart';
import '../../../core/constant/app_fonts.dart';
import '../watch_feedback_controller.dart';

class TextFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;

  TextFeedbackDisplay({
    super.key,
    required this.controller,
    required this.category,
  });

  final WatchFeedbackController controller;
  final textfeedbackController = Get.put(TextFeedbackDetailController());
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: controller.feedbackListText.length,
      separatorBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: Divider(
          color: AppColors.btnUnSelectColor,
        ),
      ),
      itemBuilder: (context, index) {
        var feedback = controller.feedbackList[index];

        var feedbackText = controller.feedbackListText[index];
        return GestureDetector(
          onTap: () {
            log("tapppppppppppppppppppppp");
            Get.to(() => FeedbackDetailScreen(
                  category: FeedbackCategory.text,
                  feedback: feedback,
                ));
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 12,
            children: [
              Row(
                spacing: 12,
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: (feedbackText['branchThumbnail'] != null &&
                            feedbackText['branchThumbnail'].isNotEmpty)
                        ? NetworkImage(feedbackText['branchThumbnail'])
                        : null,
                    child: (feedbackText['branchThumbnail'] == null ||
                            feedbackText['branchThumbnail'].isEmpty)
                        ? Icon(Icons.image_not_supported, size: 25)
                        : null,
                  ),
                  Text(
                    "Full Name",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  )
                ],
              ),
              Text(
                feedbackText['review'] ?? "No feedback available",
                style: AppTextStyles.regularStyle.copyWith(
                  color: AppColors.textColor.withCustomOpacity(.6),
                ),
              ),
              Row(
                spacing: 12,
                children: [
                  Icon(
                    Icons.favorite_border_outlined,
                    color: AppColors.mainColor,
                  ),
                  Text('12',
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandBold,
                      )),
                  Container(
                    color: AppColors.mainColor.withCustomOpacity(.4),
                    height: 20,
                    width: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      log("Feedback ID onTap: ${feedbackText['feedbackId']}");

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
                  Container(
                    color: AppColors.mainColor.withCustomOpacity(.4),
                    height: 20,
                    width: 1,
                  ),
                  Text(
                    feedbackText['created_at'] ?? "",
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.btnUnSelectColor,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
