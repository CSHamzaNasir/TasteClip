import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/components/image_feedback_card.dart';
import 'package:tasteclip/modules/explore/detail/image_feedback_detail_controller.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_fonts.dart';
import '../detail/feedback_detail_screen.dart';
import '../watch_feedback_controller.dart';

class ImageFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;
  final FeedbackScope? feedback;
  final FeedImageStoryHome? feedImageStoryHome;

  ImageFeedbackDisplay({
    super.key,
    required this.category,
    this.feedback,
    this.feedImageStoryHome,
  });

  final controller = Get.put(WatchFeedbackController());
  final imageFeedbackController = Get.put(ImageFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.feedbackList.isEmpty) {
        return Center(
          child: Text(
            "No feedback available",
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor.withCustomOpacity(0.6),
              fontFamily: AppFonts.sandBold,
            ),
          ),
        );
      }

      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: controller.feedbackList.length,
        itemBuilder: (context, index) {
          var feedback = controller.feedbackList[index];
          return InkWell(
            onTap: () => Get.to(() => FeedbackDetailScreen(feedback: feedback)),
            child: ImageFeedbackCard(
                feedback: feedback,
                imageFeedbackController: imageFeedbackController),
          );
        },
      );
    });
  }
}
