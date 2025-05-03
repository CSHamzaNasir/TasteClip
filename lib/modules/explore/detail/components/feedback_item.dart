import 'package:cached_network_image/cached_network_image.dart';
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
import 'package:video_player/video_player.dart';

class FeedbackItem extends StatelessWidget {
  final UploadFeedbackModel feedback;
  final FeedbackScope feedbackScope;
  final String? branchId;
  final WatchFeedbackController controller;

  FeedbackItem({
    super.key,
    required this.feedback,
    required this.feedbackScope,
    this.branchId,
  }) : controller = Get.find<WatchFeedbackController>();

  @override
  Widget build(BuildContext context) {
    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    if (feedbackScope == FeedbackScope.branchFeedback &&
        feedback.branchId != branchId) {
      return const SizedBox.shrink();
    }

    return FutureBuilder<AuthModel?>(
      future: controller.getUserDetails(feedback.userId),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {}

        final user = userSnapshot.data;
        if (user == null) {
          return const SizedBox.shrink();
        }

        if (feedbackScope == FeedbackScope.currentUserFeedback) {
          return feedback.category == 'video_feedback'
              ? forCurrentUserVideoFeedback(user)
              : forCurrentUserImageFeedback(user);
        } else {
          return feedback.category == 'text_feedback'
              ? forTextAllFeedback(user)
              : forVisualAllFeedback(user);
        }
      },
    );
  }

  Container forTextAllFeedback(AuthModel user) {
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ProfileImageWithShimmer(
                          imageUrl: user.profileImage,
                        ),
                        8.horizontal,
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.fullName,
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
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.all(6),
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
                    8.vertical,
                    Text(
                      feedback.hashTags.map((tag) => '#$tag').join(' '),
                      style: AppTextStyles.lightStyle.copyWith(
                        color: Colors.blueAccent,
                        fontFamily: AppFonts.sandSemiBold,
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
                      child: _buildCachedImage(
                        feedback.branchThumbnail!,
                        height: 110,
                        width: 80,
                      ),
                    ),
                    Positioned(
                      bottom: -20,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: _buildProfileImage(user.profileImage),
                      ),
                    ),
                  ],
                )
        ],
      ),
    );
  }

  Container forVisualAllFeedback(AuthModel user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ProfileImageWithShimmer(
                imageUrl: user.profileImage,
              ),
              8.horizontal,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
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
              const Spacer(),
              Container(
                padding: const EdgeInsets.all(6),
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
          if (feedback.category != 'video_feedback' &&
              feedback.mediaUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: _buildCachedImage(
                feedback.category == 'text_feedback'
                    ? feedback.branchThumbnail!
                    : feedback.mediaUrl!,
                height: 300,
                width: double.infinity,
              ),
            ),
          if (feedback.category == 'video_feedback' &&
              feedback.mediaUrl != null)
            _buildVideoPlayer(feedback.feedbackId),
          8.vertical,
          _buildLikesSection(),
        ],
      ),
    );
  }

  Container forCurrentUserVideoFeedback(AuthModel user) {
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
              _buildVideoPlayer(feedback.feedbackId, height: 140, width: 100),
              Positioned(
                bottom: -20,
                left: 0,
                right: 0,
                child: Center(
                  child: _buildProfileImage(user.profileImage),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Container forCurrentUserImageFeedback(AuthModel user) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: _buildCachedImage(
          feedback.mediaUrl!,
          height: 200,
          width: 200,
        ),
      ),
    );
  }

  Widget _buildCachedImage(String url, {double? height, double? width}) {
    return CachedNetworkImage(
      height: height,
      width: width,
      imageUrl: url,
      fit: BoxFit.cover,
      placeholder: (context, url) => const ShimmerWidget.rectangular(),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, color: Colors.grey),
      ),
    );
  }

  Widget _buildProfileImage(String? imageUrl) {
    return Container(
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
            imageUrl ?? '',
          ),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(String feedbackId,
      {double height = 300, double? width}) {
    return GetBuilder<WatchFeedbackController>(
      builder: (controller) {
        if (!controller.isVideoInitialized(feedbackId)) {
          return SizedBox(
            height: height,
            width: width,
            child: const ShimmerWidget.rectangular(),
          );
        }
        return SizedBox(
          height: height,
          width: width ?? double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: VideoPlayer(
              controller.getVideoController(feedbackId)!,
            ),
          ),
        );
      },
    );
  }

  Widget _buildLikesSection() {
    if (feedback.likes.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Text(
          "Liked by ",
          style: AppTextStyles.regularStyle.copyWith(
            color: AppColors.textColor,
          ),
        ),
        FutureBuilder<AuthModel?>(
          future: controller.getUserDetails(feedback.likes.last),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ShimmerWidget.rectangular(height: 14, width: 60);
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
    );
  }
}

class ProfileImageWithShimmer extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const ProfileImageWithShimmer({
    super.key,
    this.imageUrl,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(size / 2),
        child: CachedNetworkImage(
          imageUrl: imageUrl ?? '',
          fit: BoxFit.cover,
          placeholder: (context, url) => ShimmerWidget.circular(
            width: size,
            height: size,
          ),
          errorWidget: (context, url, error) => Icon(
            Icons.person,
            size: size * 0.6,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final ShapeBorder shapeBorder;

  const ShimmerWidget.rectangular({
    super.key,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : shapeBorder = const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8)),
        );

  const ShimmerWidget.circular({
    super.key,
    required this.width,
    required this.height,
  }) : shapeBorder = const CircleBorder();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: ShapeDecoration(
        color: Colors.grey[300]!,
        shape: shapeBorder,
      ),
      child: _buildShimmerEffect(),
    );
  }

  Widget _buildShimmerEffect() {
    return ShaderMask(
      blendMode: BlendMode.srcATop,
      shaderCallback: (bounds) {
        return LinearGradient(
          colors: [
            Colors.grey[300]!,
            Colors.grey[100]!,
            Colors.grey[300]!,
          ],
          stops: const [0.1, 0.5, 0.9],
          begin: const Alignment(-1.0, -0.5),
          end: const Alignment(1.0, 0.5),
          tileMode: TileMode.clamp,
        ).createShader(bounds);
      },
      child: Container(
        width: width,
        height: height,
        color: Colors.grey[300],
      ),
    );
  }
}
