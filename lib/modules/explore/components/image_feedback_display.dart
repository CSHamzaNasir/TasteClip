import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_fonts.dart';
import '../detail/feedback_detail_screen.dart';
import '../watch_feedback_controller.dart';

class ImageFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;

  const ImageFeedbackDisplay({
    super.key,
    required this.controller,
    required this.category,
  });

  final WatchFeedbackController controller;

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
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1,
        ),
        itemCount: controller.feedbackList.length,
        itemBuilder: (context, index) {
          var feedback = controller.feedbackList[index];
          return InkWell(
            onTap: () => Get.to(() => FeedbackDetailScreen(
                  feedback: feedback,
                  category: FeedbackCategory.image,
                )),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.mainColor.withCustomOpacity(.2)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: (feedback['imageUrl'] != null &&
                                feedback['imageUrl'].isNotEmpty)
                            ? Center(
                                child: Image.network(
                                  feedback['imageUrl'],
                                  fit: BoxFit.cover,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Center(
                                        child: CupertinoActivityIndicator());
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return Center(
                                      child: Icon(Icons.image_not_supported,
                                          size: 25),
                                    );
                                  },
                                ),
                              )
                            : Center(
                                child:
                                    Icon(Icons.image_not_supported, size: 25),
                              ),
                      ),
                    ),
                  ),
                  8.vertical,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            '@${feedback['restaurantName'] ?? "Unknown"}',
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
                          feedback['rating'] ?? "0.0",
                          style: AppTextStyles.lightStyle.copyWith(
                            color: AppColors.textColor.withCustomOpacity(.5),
                            fontFamily: AppFonts.sandSemiBold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
