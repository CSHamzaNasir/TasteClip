import 'package:flutter/material.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import '../../../constant/app_fonts.dart';
import '../watch_feedback_controller.dart';

class TextFeedbackDisplay extends StatelessWidget {
  const TextFeedbackDisplay({
    super.key,
    required this.controller,
  });

  final WatchFeedbackController controller;

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
        var feedbackText = controller.feedbackListText[index];
        return Column(
          spacing: 12,
          children: [
            Row(
              spacing: 12,
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: (feedbackText['branchThumbnail'] != null &&
                          feedbackText['branchThumbnail'].isNotEmpty)
                      ? NetworkImage(feedbackText['branchThumbnail'])
                      : null,
                  child: (feedbackText['branchThumbnail'] == null ||
                          feedbackText['branchThumbnail'].isEmpty)
                      ? Icon(Icons.image_not_supported, size: 25)
                      : null,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Full Name",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.mainColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                    Text(
                      "@username",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.primaryColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryColor),
                color: AppColors.mainColor.withCustomOpacity(.1),
              ),
              child: Text(
                feedbackText['feedback_text'] ?? "No feedback available",
                style: AppTextStyles.regularStyle.copyWith(
                  color: AppColors.mainColor.withCustomOpacity(.7),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.favorite_border_outlined,
                  color: AppColors.mainColor,
                ),
                SizedBox(width: 4),
                Text('12',
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.mainColor,
                      fontFamily: AppFonts.sandBold,
                    )),
                Spacer(),
                Text(
                  feedbackText['created_at'] ?? "",
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.btnUnSelectColor,
                    fontFamily: AppFonts.sandSemiBold,
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
