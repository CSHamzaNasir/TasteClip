import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';

import '../../../config/app_text_styles.dart';
import '../../../constant/app_fonts.dart';
import '../detail/feedback_detail_screen.dart';
import '../watch_feedback_controller.dart';

class ImageFeedbackDisplay extends StatelessWidget {
  const ImageFeedbackDisplay({
    super.key,
    required this.controller,
  });

  final WatchFeedbackController controller;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: .9,
      ),
      itemCount: controller.feedbackList.length,
      itemBuilder: (context, index) {
        var feedback = controller.feedbackList[index];
        return InkWell(
          onTap: () => Get.to(() => FeedbackDetailScreen(feedback: feedback)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              (feedback['image_url'] != null &&
                      feedback['image_url'].isNotEmpty)
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        feedback['image_url'],
                        width: double.infinity,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                    )
                  : Icon(Icons.image_not_supported, size: 25),
              Row(
                spacing: 6,
                children: [
                  Expanded(
                    child: Text(
                      '@${feedback['channelName']}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(.5),
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    ),
                  ),
                  Icon(
                    size: 16,
                    Icons.star,
                    color: Colors.amber,
                  ),
                  Text(
                    feedback['rating'],
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.textColor.withCustomOpacity(.5),
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                  16.vertical,
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
