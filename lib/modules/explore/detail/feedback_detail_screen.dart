import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/detail/components/like_interaction.dart';
import 'package:tasteclip/modules/explore/detail/components/user_info.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';

class FeedbackDetailScreen extends StatelessWidget {
  final UploadFeedbackModel feedback;
  final FeedbackScope feedbackScope;

  FeedbackDetailScreen(
      {super.key, required this.feedback, required this.feedbackScope});

  final controller = Get.put(WatchFeedbackController());
  @override
  Widget build(BuildContext context) {
    log(feedback.category);
    final user = controller.getUserDetails(feedback.userId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          SvgPicture.asset(AppAssets.coinLogo, width: 24),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 12),
            child: Text(
              feedback.tasteCoin.toString(),
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.whiteColor,
                fontSize: 16,
              ),
            ),
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 18,
              color: AppColors.whiteColor,
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          "Feedback Details",
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: feedback.category == 'text_feedback'
                  ? feedback.branchThumbnail!
                  : feedback.mediaUrl!,
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              placeholder: (context, url) =>
                  const Center(child: CircularProgressIndicator()),
              errorWidget: (context, url, error) =>
                  const Center(child: Icon(Icons.error)),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withCustomOpacity(0.6),
                  Colors.black.withCustomOpacity(0.3),
                  Colors.black.withCustomOpacity(0.6),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Spacer(),
              LikesInteraction(
                feedback: feedback,
                feedbackScope: feedbackScope,
              ),
              Spacer(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16),
                child: UserInfoWidget(
                  user: user,
                  feedback: feedback,
                  controller: controller,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
