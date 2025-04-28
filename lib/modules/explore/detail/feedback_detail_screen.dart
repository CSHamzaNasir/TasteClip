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
import 'package:tasteclip/modules/explore/detail/components/comments_bottom_sheet.dart';
import 'package:tasteclip/modules/explore/detail/components/like_interaction.dart';
import 'package:tasteclip/modules/explore/detail/components/user_info.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:video_player/video_player.dart';

class FeedbackDetailScreen extends StatefulWidget {
  final UploadFeedbackModel feedback;
  final FeedbackScope feedbackScope;

  const FeedbackDetailScreen(
      {super.key, required this.feedback, required this.feedbackScope});

  @override
  State<FeedbackDetailScreen> createState() => _FeedbackDetailScreenState();
}

class _FeedbackDetailScreenState extends State<FeedbackDetailScreen> {
  late final WatchFeedbackController controller;
  late VideoPlayerController _videoController;
  bool _isVideoInitialized = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WatchFeedbackController>();
    if (widget.feedback.category == 'video_feedback') {
      _initializeVideoPlayer();
    }
  }

  void _initializeVideoPlayer() {
    // ignore: deprecated_member_use
    _videoController = VideoPlayerController.network(widget.feedback.mediaUrl!)
      ..initialize().then((_) {
        if (mounted) {
          setState(() {
            _isVideoInitialized = true;
            _videoController.setLooping(true);
            _videoController.play();
          });
        }
      }).catchError((error) {
        log('Video initialization error: $error');
      });
  }

  @override
  void dispose() {
    if (widget.feedback.category == 'video_feedback') {
      _videoController.dispose();
    }
    super.dispose();
  }

  Widget _buildMediaContent() {
    if (widget.feedback.category == 'video_feedback') {
      return _buildVideoPlayer();
    }

    return CachedNetworkImage(
      imageUrl: widget.feedback.category == 'text_feedback'
          ? widget.feedback.branchThumbnail!
          : widget.feedback.mediaUrl!,
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      placeholder: (context, url) => const Center(
        child: CupertinoActivityIndicator(color: AppColors.whiteColor),
      ),
      errorWidget: (context, url, error) => const Center(
        child: Icon(Icons.error, color: AppColors.whiteColor),
      ),
    );
  }

  Widget _buildVideoPlayer() {
    if (!_isVideoInitialized) {
      return const Center(
        child: CupertinoActivityIndicator(color: AppColors.whiteColor),
      );
    }

    return GestureDetector(
      onTap: () {
        setState(() {
          _videoController.value.isPlaying
              ? _videoController.pause()
              : _videoController.play();
        });
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoController.value.aspectRatio,
            child: VideoPlayer(_videoController),
          ),
          if (!_videoController.value.isPlaying)
            Icon(
              Icons.play_arrow,
              color: Colors.white,
              size: 50,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = controller.getUserDetails(widget.feedback.userId);

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          SvgPicture.asset(AppAssets.coinLogo, width: 24),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 12),
            child: Text(
              widget.feedback.tasteCoin.toString(),
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
          Positioned.fill(child: _buildMediaContent()),
          widget.feedback.category == 'text_feedback'
              ? Container(
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
                )
              : SizedBox.shrink(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Spacer(),
              LikesInteraction(
                feedback: widget.feedback,
                feedbackScope: widget.feedbackScope,
                commentSheet: () {
                  CommentsBottomSheet(
                    feedbackId: widget.feedback.feedbackId,
                  ).show(context);
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0)
                    .copyWith(bottom: 16),
                child: SafeArea(
                  child: UserInfoWidget(
                    user: user,
                    feedback: widget.feedback,
                    controller: controller,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
