import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
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
  final FeedbackScope feedbackScope;
  final String? branchId;

  const FeedbackItem({
    super.key,
    required this.feedback,
    required this.feedbackScope,
    this.branchId,
  });

  @override
  Widget build(BuildContext context) {
    log(branchId.toString());
    final controller = Get.put(WatchFeedbackController());
    final user = controller.getUserDetails(feedback.userId);

    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    if (feedbackScope == FeedbackScope.branchFeedback &&
        feedback.branchId != branchId) {
      return Container();
    }

    log(branchId.toString());

    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    return Container(
      width: feedbackScope == FeedbackScope.allFeedback ? 150 : double.infinity,
      height: feedback.category != 'text_feedback' ? 400 : 196,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          feedback.category == 'video_feedback'
              ? 8
              : feedbackScope != FeedbackScope.currentUserFeedback
                  ? 36
                  : 12,
        ),
        color:
            (feedback.category != 'image_feedback' || feedback.mediaUrl == null)
                ? AppColors.mainColor.withCustomOpacity(.2)
                : null,
      ),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Stack(
        children: [
          if (feedback.category != 'video_feedback')
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: feedback.category == 'text_feedback'
                    ? feedback.branchThumbnail!
                    : feedback.mediaUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) =>
                    const Center(child: CupertinoActivityIndicator()),
                errorWidget: (context, url, error) =>
                    const Center(child: Icon(Icons.error)),
              ),
            ),
          if (feedback.category == 'video_feedback' &&
              feedback.mediaUrl != null)
            GetBuilder<WatchFeedbackController>(
              builder: (controller) {
                if (!controller.isVideoInitialized(feedback.feedbackId)) {
                  return const Center(child: CupertinoActivityIndicator());
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
          feedbackScope != FeedbackScope.currentUserFeedback &&
                  feedback.category != 'video_feedback'
              ? Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 180,
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
                  ),
                )
              : SizedBox.shrink(),
          Padding(
            padding: const EdgeInsets.all(16),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  feedbackScope != FeedbackScope.currentUserFeedback &&
                          feedback.category != 'video_feedback'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    AppColors.lightColor.withCustomOpacity(0.3),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        child: Text(
                                          user?.fullName ?? 'Loading...',
                                          style: AppTextStyles.regularStyle
                                              .copyWith(
                                            color: AppColors.textColor,
                                            fontFamily: AppFonts.sandSemiBold,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        controller
                                            .formatDate(feedback.createdAt),
                                        style:
                                            AppTextStyles.lightStyle.copyWith(
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
                        )
                      : SizedBox.shrink(),
                  feedbackScope != FeedbackScope.currentUserFeedback &&
                          feedback.category != 'video_feedback'
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(32),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                            child: Container(
                              decoration: BoxDecoration(
                                color:
                                    AppColors.mainColor.withCustomOpacity(0.1),
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
                        )
                      : SizedBox.shrink(),
                ],
              ),
              if (feedback.category == 'text_feedback') ...[
                12.vertical,
                feedbackScope != FeedbackScope.currentUserFeedback &&
                        feedback.category != 'video_feedback'
                    ? Text(
                        feedback.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regularStyle.copyWith(
                          color: Colors.white,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
              const Spacer(),
              feedbackScope != FeedbackScope.currentUserFeedback &&
                      feedback.category != 'video_feedback'
                  ? GetBuilder<WatchFeedbackController>(
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
                              onTap: () => controller
                                  .toggleLike(currentFeedback.feedbackId),
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
                    )
                  : SizedBox.shrink(),
              feedback.category != 'video_feedback'
                  ? 16.vertical
                  : SizedBox.shrink(),
              feedbackScope == FeedbackScope.currentUserFeedback ||
                      feedbackScope == FeedbackScope.allFeedback
                  ? Center(
                      child: Row(
                        spacing: 8,
                        children: [
                          Container(
                            width: 30,
                            height: 30,
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              border: Border.all(color: AppColors.lightColor),
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    feedbackScope == FeedbackScope.allFeedback
                                        ? (user?.profileImage ?? '')
                                        : (feedback.branchThumbnail ?? '')),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Text(
                              feedbackScope == FeedbackScope.allFeedback
                                  ? (user?.fullName ?? 'Unknown User')
                                  : (feedback.branchName),
                              style: AppTextStyles.lightStyle.copyWith(
                                  color: AppColors.whiteColor,
                                  fontFamily: AppFonts.sandBold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox.shrink(),
              feedback.category != 'video_feedback'
                  ? 16.vertical
                  : SizedBox.shrink(),
              if (feedback.category != 'text_feedback') ...[
                feedbackScope != FeedbackScope.currentUserFeedback &&
                        feedback.category != 'video_feedback'
                    ? Text(
                        feedback.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.regularStyle.copyWith(
                          color: Colors.white,
                          fontFamily: AppFonts.sandSemiBold,
                        ),
                      )
                    : SizedBox.shrink(),
              ],
              if (feedback.category == 'video_feedback' &&
                  feedback.mediaUrl != null &&
                  feedbackScope != FeedbackScope.allFeedback &&
                  feedbackScope != FeedbackScope.currentUserFeedback) ...[
                GetBuilder<WatchFeedbackController>(
                  builder: (controller) {
                    if (!controller.isVideoInitialized(feedback.feedbackId)) {
                      return const Center(child: CupertinoActivityIndicator());
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
            ]),
          ),
        ],
      ),
    );
  }
}
