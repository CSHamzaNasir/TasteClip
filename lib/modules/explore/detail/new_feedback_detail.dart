import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:video_player/video_player.dart';

class NewFeedbackDetailScreen extends StatelessWidget {
  final UploadFeedbackModel feedback;

  const NewFeedbackDetailScreen({super.key, required this.feedback});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(WatchFeedbackController());
    final user = controller.getUserDetails(feedback.userId);

    if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
      controller.initializeVideo(feedback.feedbackId, feedback.mediaUrl!);
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: feedback.category != 'text_feedback' ? 300 : 150,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: _buildMediaContent(controller),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Get.back(),
            ),
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  AppAssets.vertMore,
                ),
                onPressed: () {},
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserInfo(user),
                  16.vertical,
                  Text(
                    feedback.description,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandSemiBold,
                      fontSize: 16,
                    ),
                  ),
                  24.vertical,
                  _buildRestaurantInfo(),
                  24.vertical,
                  _buildLikeCommentSection(controller),
                  24.vertical,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMediaContent(WatchFeedbackController controller) {
    if (feedback.category == 'image_feedback' && feedback.mediaUrl != null) {
      return CachedNetworkImage(
        imageUrl: feedback.mediaUrl!,
        fit: BoxFit.cover,
        placeholder: (context, url) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (context, url, error) =>
            const Center(child: Icon(Icons.error)),
      );
    } else if (feedback.category == 'video_feedback' &&
        feedback.mediaUrl != null) {
      return GetBuilder<WatchFeedbackController>(
        builder: (controller) {
          if (!controller.isVideoInitialized(feedback.feedbackId)) {
            return const Center(child: CircularProgressIndicator());
          }
          return Stack(
            children: [
              Positioned.fill(
                child: AspectRatio(
                  aspectRatio: controller
                      .getVideoController(feedback.feedbackId)!
                      .value
                      .aspectRatio,
                  child: VideoPlayer(
                      controller.getVideoController(feedback.feedbackId)!),
                ),
              ),
              Center(
                child: IconButton(
                  icon: Icon(
                    controller.isVideoPlaying(feedback.feedbackId)
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: Colors.white,
                    size: 50,
                  ),
                  onPressed: () =>
                      controller.toggleVideoPlayback(feedback.feedbackId),
                ),
              ),
            ],
          );
        },
      );
    } else {
      return Container(
        color: AppColors.mainColor.withCustomOpacity(.2),
      );
    }
  }

  Widget _buildUserInfo(AuthModel? user) {
    return Row(
      children: [
        ProfileImageWithShimmer(
          imageUrl: user?.profileImage,
          radius: 24,
        ),
        12.horizontal,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.fullName ?? 'Loading...',
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.textColor,
                fontFamily: AppFonts.sandSemiBold,
              ),
            ),
            4.vertical,
            // Text(
            //   controller.formatDate(feedback.createdAt),
            //   style: AppTextStyles.lightStyle.copyWith(
            //     color: AppColors.textColor.withCustomOpacity(.3),
            //     fontFamily: AppFonts.sandSemiBold,
            //   ),
            // )
          ],
        ),
        const Spacer(),
        SvgPicture.asset(AppAssets.coinLogo, width: 24),
        8.horizontal,
        Text(
          feedback.tasteCoin.toString(),
          style: AppTextStyles.regularStyle.copyWith(
            color: AppColors.textColor,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantInfo() {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
              image: CachedNetworkImageProvider(feedback.branchThumbnail ?? ''),
              fit: BoxFit.cover,
            ),
          ),
        ),
        12.horizontal,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              feedback.restaurantName,
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.textColor,
                fontFamily: AppFonts.sandSemiBold,
              ),
            ),
            4.vertical,
            Text(
              feedback.branchName,
              style: AppTextStyles.lightStyle.copyWith(
                color: AppColors.textColor.withCustomOpacity(.5),
                fontFamily: AppFonts.sandSemiBold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLikeCommentSection(WatchFeedbackController controller) {
    return GetBuilder<WatchFeedbackController>(
      builder: (controller) {
        final currentFeedback = feedback;
        final isLiked = controller.isLikedByCurrentUser(currentFeedback);
        final likeCount = currentFeedback.likes.length;

        return Row(
          children: [
            GestureDetector(
              onTap: () => controller.toggleLike(currentFeedback.feedbackId),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: AppColors.mainColor.withCustomOpacity(.1),
                ),
                child: Row(
                  children: [
                    SvgPicture.asset(
                      height: 24,
                      width: 24,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                          isLiked ? AppColors.mainColor : AppColors.textColor,
                          BlendMode.srcIn),
                      isLiked ? AppAssets.likeThumb : AppAssets.likeBorder,
                    ),
                    8.horizontal,
                    Text(
                      likeCount.toString(),
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            16.horizontal,
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: AppColors.mainColor.withCustomOpacity(.1),
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    height: 24,
                    width: 24,
                    fit: BoxFit.cover,
                    colorFilter: const ColorFilter.mode(
                        AppColors.textColor, BlendMode.srcIn),
                    AppAssets.messageFilled,
                  ),
                  8.horizontal,
                  Text(
                    '7', // Replace with actual comment count
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
