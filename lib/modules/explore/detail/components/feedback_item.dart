import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:video_player/video_player.dart';

class FeedbackItem extends StatelessWidget {
  final UploadFeedbackModel feedback;

  const FeedbackItem({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WatchFeedbackController());
    final user = controller.getUserDetails(feedback.userId);

    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    return Container(
      height: feedback.category != 'text_feedback' ? 400 : 160,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(36),
        color:
            (feedback.category != 'image_feedback' || feedback.mediaUrl == null)
                ? AppColors.mainColor.withCustomOpacity(.2)
                : null,
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          // Background content (image or video)
          if (feedback.category == 'image_feedback' &&
              feedback.mediaUrl != null)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: feedback.mediaUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),

          if (feedback.category == 'video_feedback' &&
              feedback.mediaUrl != null)
            GetBuilder<WatchFeedbackController>(
              builder: (controller) {
                if (!controller.isVideoInitialized(feedback.feedbackId)) {
                  return const Center(child: CircularProgressIndicator());
                }
                return Positioned.fill(
                  child: AspectRatio(
                    aspectRatio: controller
                        .getVideoController(feedback.feedbackId)!
                        .value
                        .aspectRatio,
                    child: VideoPlayer(
                        controller.getVideoController(feedback.feedbackId)!),
                  ),
                );
              },
            ),

          // Gradient overlay
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 180,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(
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
            ),
          ),

          // Content overlay
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // User Info Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(32),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.lightColor.withCustomOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                            backgroundBlendMode: BlendMode.overlay,
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 8),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ProfileImageWithShimmer(
                                imageUrl: user?.profileImage,
                                radius: 18,
                              ),
                              12.horizontal,
                              Column(
                                spacing: 2,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 100,
                                    child: Text(
                                      user?.fullName ?? 'Loading...',
                                      style:
                                          AppTextStyles.regularStyle.copyWith(
                                        color: AppColors.textColor,
                                        fontFamily: AppFonts.sandSemiBold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Text(
                                    controller.formatDate(feedback.createdAt),
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
                            colorFilter: const ColorFilter.mode(
                              AppColors.textColor,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                if (feedback.category == 'text_feedback') ...[
                  12.vertical,
                  Text(
                    feedback.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: Colors.white,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                ],

                const Spacer(),

                // Interaction Row with GetBuilder for likes
                GetBuilder<WatchFeedbackController>(
                  builder: (controller) {
                    final currentFeedback = controller.feedbacks.firstWhere(
                      (f) => f.feedbackId == feedback.feedbackId,
                      orElse: () => feedback,
                    );
                    final isLiked =
                        controller.isLikedByCurrentUser(currentFeedback);
                    final likeCount = currentFeedback.likes.length;

                    return Row(
                      children: [
                        GestureDetector(
                          onTap: () =>
                              controller.toggleLike(currentFeedback.feedbackId),
                          child: Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.white.withCustomOpacity(.2),
                            ),
                            child: SvgPicture.asset(
                              height: 18,
                              width: 18,
                              fit: BoxFit.cover,
                              colorFilter: ColorFilter.mode(
                                  Colors.white, BlendMode.srcIn),
                              isLiked
                                  ? AppAssets.likeThumb
                                  : AppAssets.likeBorder,
                            ),
                          ),
                        ),
                        8.horizontal,
                        Text(
                          likeCount > 0 ? likeCount.toString() : '',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        16.horizontal,
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: Colors.white.withCustomOpacity(.2),
                          ),
                          child: SvgPicture.asset(
                            height: 18,
                            width: 18,
                            fit: BoxFit.cover,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                            AppAssets.messageFilled,
                          ),
                        ),
                        8.horizontal,
                        Text(
                          '7',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        16.horizontal,
                        SvgPicture.asset(
                          AppAssets.coinLogo,
                          width: 24,
                        ),
                        8.horizontal,
                        Text(
                          likeCount > 0 ? likeCount.toString() : '',
                          style: AppTextStyles.regularStyle.copyWith(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '@${feedback.restaurantName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.lightStyle.copyWith(
                            color: Colors.white,
                            fontFamily: AppFonts.sandSemiBold,
                          ),
                        ),
                      ],
                    );
                  },
                ),

                if (feedback.category != 'text_feedback') ...[
                  16.vertical,
                  Text(
                    feedback.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: Colors.white,
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  ),
                ],

                if (feedback.category == 'video_feedback' &&
                    feedback.mediaUrl != null)
                  GetBuilder<WatchFeedbackController>(
                    builder: (controller) {
                      if (!controller.isVideoInitialized(feedback.feedbackId)) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      return IconButton(
                        icon: Icon(
                          controller.isVideoPlaying(feedback.feedbackId)
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                        ),
                        onPressed: () =>
                            controller.toggleVideoPlayback(feedback.feedbackId),
                      );
                    },
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
