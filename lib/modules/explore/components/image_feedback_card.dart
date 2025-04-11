import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/detail/image_feedback_detail_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_fonts.dart';

class ImageFeedbackCard extends StatelessWidget {
  final FeedbackScope? feedbackScope;
  ImageFeedbackCard({
    super.key,
    required this.feedback,
    this.feedbackScope,
  });

  final Map<String, dynamic> feedback;
  final imageFeedbackController = Get.put(ImageFeedbackDetailController());

  @override
  Widget build(BuildContext context) {
    log(feedbackScope.toString());
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        image: feedback['imageUrl'] != null && feedback['imageUrl'].isNotEmpty
            ? DecorationImage(
                image: NetworkImage(feedback['imageUrl']),
                fit: BoxFit.cover,
                onError: (error, stackTrace) =>
                    Icon(Icons.image_not_supported, size: 25),
              )
            : null,
        color: feedback['imageUrl'] == null || feedback['imageUrl'].isEmpty
            ? AppColors.mainColor.withCustomOpacity(.2)
            : null,
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(36),
                  bottomRight: Radius.circular(36),
                ),
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withCustomOpacity(0.7),
                    Colors.transparent,
                  ],
                ),
              ),
              height: 180,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightColor.withCustomOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            backgroundBlendMode: BlendMode.overlay,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      feedback['user_fullName'] ??
                                          "Unknown User",
                                      style: AppTextStyles.bodyStyle.copyWith(
                                        color: AppColors.mainColor,
                                        fontFamily: AppFonts.sandSemiBold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    feedback['created_at'] ?? "",
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.textColor
                                          .withCustomOpacity(.3),
                                      fontFamily: AppFonts.sandSemiBold,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.mainColor.withCustomOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                            backgroundBlendMode: BlendMode.overlay,
                          ),
                          padding: const EdgeInsets.all(16),
                          child: SvgPicture.asset(
                            AppAssets.vertMore,
                            height: 24,
                            width: 24,
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                              AppColors.textColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withCustomOpacity(.2)),
                    child: SvgPicture.asset(
                      height: 18,
                      width: 18,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                  24.horizontal,
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.white.withCustomOpacity(.2)),
                    child: SvgPicture.asset(
                      height: 18,
                      width: 18,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                      AppAssets.messageFilled,
                    ),
                  ),
                  12.horizontal,
                  Obx(
                    () => Text(
                      "${imageFeedbackController.likes.length}",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    '@${feedback['restaurantName'] ?? "Unknown"}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.lightStyle.copyWith(
                      color: Colors.white,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  )
                ]),
                16.vertical,
                Text(
                  feedback['description'] ?? "No review available",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.regularStyle.copyWith(
                    color: Colors.white,
                    fontFamily: AppFonts.sandSemiBold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
