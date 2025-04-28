import 'dart:developer';

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
import 'package:tasteclip/core/data/models/auth_models.dart';
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
    log(feedbackScope.toString());
    log(feedback.category.toString());
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

    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    return feedbackScope == FeedbackScope.currentUserFeedback &&
            feedback.category == 'video_feedback'
        ? forCurrentUserVideoFeedback(user, controller)
        : feedbackScope == FeedbackScope.currentUserFeedback &&
                feedback.category == 'image_feedback'
            ? forCurrentUserImageFeedback(user, controller)
            : feedback.category == 'image_feedback' ||
                    feedback.category == 'video_feedback'
                ? forVisualAllFeedback(user, controller)
                : forTextAllFeedback(user, controller);
  }

  Container forTextAllFeedback(
      AuthModel? user, WatchFeedbackController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: EdgeInsets.symmetric(
          horizontal: feedbackScope == FeedbackScope.branchFeedback ? 0 : 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          feedbackScope == FeedbackScope.branchFeedback
              ? Column(
                  children: [
                    Row(
                      spacing: 8,
                      children: [
                        ProfileImageWithShimmer(
                          imageUrl: user?.profileImage,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user!.fullName,
                              style: AppTextStyles.regularStyle.copyWith(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                            Text(
                              controller.formatDate(feedback.createdAt),
                              style: AppTextStyles.lightStyle.copyWith(
                                color:
                                    AppColors.textColor.withCustomOpacity(.3),
                                fontFamily: AppFonts.sandSemiBold,
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color:
                                  AppColors.primaryColor.withCustomOpacity(.1)),
                          child: SvgPicture.asset(
                            AppAssets.message,
                            height: 20,
                            width: 20,
                            fit: BoxFit.cover,
                          ),
                        )
                      ],
                    ),
                    16.vertical,
                    Text(
                      feedback.description,
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandMedium,
                      ),
                    ),
                    16.vertical,
                  ],
                )
              : Stack(
                  clipBehavior: Clip.none,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: CachedNetworkImage(
                        height: 110,
                        width: 80,
                        imageUrl: feedback.branchThumbnail!,
                        fit: BoxFit.cover,
                        placeholder: (context, url) =>
                            const Center(child: CupertinoActivityIndicator()),
                        errorWidget: (context, url, error) =>
                            const Center(child: Icon(Icons.error)),
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            image: DecorationImage(
                              image: CachedNetworkImageProvider(
                                user!.profileImage ?? '',
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Container forVisualAllFeedback(
      AuthModel? user, WatchFeedbackController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 8,
            children: [
              ProfileImageWithShimmer(
                imageUrl: user?.profileImage,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user!.fullName,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Text(
                    controller.formatDate(feedback.createdAt),
                    style: AppTextStyles.lightStyle.copyWith(
                      color: AppColors.textColor.withCustomOpacity(.3),
                      fontFamily: AppFonts.sandSemiBold,
                    ),
                  )
                ],
              ),
              Spacer(),
              Container(
                padding: EdgeInsets.all(6),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primaryColor.withCustomOpacity(.1)),
                child: SvgPicture.asset(
                  feedback.category == 'video_feedback'
                      ? AppAssets.video
                      : AppAssets.camera,
                  height: 20,
                  width: 20,
                  fit: BoxFit.cover,
                ),
              )
            ],
          ),
          16.vertical,
          Text(
            feedback.description,
            style: AppTextStyles.lightStyle.copyWith(
              color: AppColors.textColor,
              fontFamily: AppFonts.sandMedium,
            ),
          ),
          8.vertical,

          Text(
            feedback.hashTags.map((tag) => '#$tag').join(' '),
            style: AppTextStyles.lightStyle.copyWith(
              color: Colors.blueAccent,
              fontFamily: AppFonts.sandSemiBold,
            ),
          ),
          8.vertical,
          if (feedback.category != 'video_feedback')
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                height: 300,
                width: double.infinity,
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
                return SizedBox(
                  height: 300,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: VideoPlayer(
                      controller.getVideoController(feedback.feedbackId)!,
                    ),
                  ),
                );
              },
            ),
          8.vertical,
          Row(
            children: [
              if (feedback.likes.isNotEmpty)
                Text(
                  "Liked by ",
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              if (feedback.likes.isNotEmpty)
                FutureBuilder<AuthModel?>(
                  future: Future.value(
                      controller.getUserDetails(feedback.likes.last)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        "user",
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      );
                    }
                    final user = snapshot.data;
                    return Text(
                      user?.fullName ?? "user",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    );
                  },
                ),
              if (feedback.likes.length > 1)
                Text(
                  " and ${feedback.likes.length - 1} others",
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
            ],
          )
        ],
      ),
    );
  }

  Container forCurrentUserVideoFeedback(
      AuthModel? user, WatchFeedbackController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              GetBuilder<WatchFeedbackController>(
                builder: (controller) {
                  if (!controller.isVideoInitialized(feedback.feedbackId)) {
                    return const Center(child: CupertinoActivityIndicator());
                  }
                  return SizedBox(
                    height: 140,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: VideoPlayer(
                        controller.getVideoController(feedback.feedbackId)!,
                      ),
                    ),
                  );
                },
              ),
              Positioned(
                bottom: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(
                          user?.profileImage ?? '',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container forCurrentUserImageFeedback(
      AuthModel? user, WatchFeedbackController controller) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: CachedNetworkImage(
          height: 200,
          width: 200,
          imageUrl: feedback.mediaUrl!,
          fit: BoxFit.cover,
          placeholder: (context, url) =>
              const Center(child: CupertinoActivityIndicator()),
          errorWidget: (context, url, error) =>
              const Center(child: Icon(Icons.error)),
        ),
      ),
    );
  }
}
