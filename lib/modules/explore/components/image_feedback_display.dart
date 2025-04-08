import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/detail/image_feedback_detail_controller.dart';
import 'package:tasteclip/utils/shimmer_style.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_fonts.dart';
import '../detail/feedback_detail_screen.dart';
import '../watch_feedback_controller.dart';

class ImageFeedbackDisplay extends StatelessWidget {
  final FeedbackCategory category;
  final FeedbackScope? feedback;

  ImageFeedbackDisplay({
    super.key,
    required this.category,
    this.feedback,
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
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ProfileImageWithShimmer(
                        imageUrl: feedback['user_profileImage'],
                        radius: 18,
                      ),
                      12.horizontal,
                      Column(
                        spacing: 4,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedback['user_fullName'] ?? "Unknown User",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.mainColor,
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                          Text(
                            feedback['created_at'] ?? "",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.btnUnSelectColor
                                  .withCustomOpacity(.5),
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  16.vertical,
                  Text(
                    feedback['description'] ?? "No review available",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor.withCustomOpacity(.5),
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                  16.vertical,
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: AppColors.mainColor.withCustomOpacity(.2),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: (feedback['imageUrl'] != null &&
                                feedback['imageUrl'].isNotEmpty)
                            ? Stack(
                                alignment: Alignment.center,
                                children: [
                                  ShimmerEffect.rectangular(
                                    width: double.infinity,
                                    height: double.infinity,
                                  ),
                                  Image.network(
                                    feedback['imageUrl'],
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }

                                      return ShimmerEffect.rectangular(
                                        width: double.infinity,
                                        height: double.infinity,
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Center(
                                        child: Icon(Icons.image_not_supported,
                                            size: 25),
                                      );
                                    },
                                  ),
                                ],
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
                        Obx(
                          () => Text(
                            "${imageFeedbackController.comments.length} Comments",
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        12.horizontal,
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
                  16.vertical,
                  Row(children: [
                    // ignore: unrelated_type_equality_checks
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.mainColor.withCustomOpacity(.1)),
                      child: SvgPicture.asset(
                        height: 18,
                        width: 18,
                        fit: BoxFit.cover,
                        colorFilter: ColorFilter.mode(
                          AppColors.mainColor.withCustomOpacity(.7),
                          BlendMode.srcIn,
                        ),
                        AppAssets.likeThumb,
                      ),
                    ),
                    12.horizontal,
                    Obx(
                      () => Text(
                        "${imageFeedbackController.likes.length}",
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                    ),
                    Spacer(),
                    Text(
                      '@${feedback['restaurantName'] ?? "Unknown"}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(.5),
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    )
                  ])
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
