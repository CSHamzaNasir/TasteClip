import 'dart:developer';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/modules/explore/components/comments_bottom_sheet.dart';
import 'package:tasteclip/modules/explore/components/like_interaction.dart';
import 'package:tasteclip/modules/explore/components/user_info.dart';
import 'package:tasteclip/modules/explore/controllers/watch_feedback_controller.dart';
import 'package:tasteclip/modules/feedback/model/upload_feedback_model.dart';
import 'package:video_player/video_player.dart';

class FeedbackDetailScreen extends StatefulWidget {
  final UploadFeedbackModel feedback;
  final FeedbackScope feedbackScope;
  final UserRole? userRole;

  const FeedbackDetailScreen({
    super.key,
    required this.feedback,
    required this.feedbackScope,
    this.userRole,
  });

  @override
  State<FeedbackDetailScreen> createState() => _FeedbackDetailScreenState();
}

class _FeedbackDetailScreenState extends State<FeedbackDetailScreen> {
  late final WatchFeedbackController controller;
  late PageController _pageController;
  late int _currentPageIndex;
  late List<UploadFeedbackModel> _feedbacks;
  late final List<VideoPlayerController> _videoControllers = [];
  late int _currentTasteCoin;
  bool _allowPrevious = false;

  @override
  void initState() {
    super.initState();
    controller = Get.find<WatchFeedbackController>();
    _feedbacks = controller.feedbacks;
    _currentPageIndex = _feedbacks.indexWhere(
      (f) => f.feedbackId == widget.feedback.feedbackId,
    );
    _currentPageIndex = _currentPageIndex == -1 ? 0 : _currentPageIndex;
    _currentTasteCoin = _feedbacks[_currentPageIndex].tasteCoin;

    _pageController = PageController(
      initialPage: _currentPageIndex,
      viewportFraction: 1.0,
    );

    _initializeVideoControllers();
    controller.addListener(_updateFeedbacks);
  }

  void _initializeVideoControllers() {
    for (var feedback in _feedbacks) {
      VideoPlayerController? videoController;

      if (feedback.category == 'video_feedback' && feedback.mediaUrl != null) {
        // ignore: deprecated_member_use
        videoController = VideoPlayerController.network(feedback.mediaUrl!)
          ..initialize().then((_) {
            if (mounted) {
              setState(() {
                videoController?.setLooping(true);
                if (_currentPageIndex == _feedbacks.indexOf(feedback)) {
                  videoController?.play();
                }
              });
            }
          }).catchError((error) {
            log('Video initialization error: $error');
          });
      }

      _videoControllers
          // ignore: deprecated_member_use
          .add(videoController ?? VideoPlayerController.network(''));
    }
  }

  void _updateFeedbacks() {
    final updatedFeedbacks = controller.feedbacks;
    if (mounted && updatedFeedbacks != _feedbacks) {
      setState(() {
        _feedbacks = updatedFeedbacks;
        _currentTasteCoin = _feedbacks[_currentPageIndex].tasteCoin;
      });
    }
  }

  void _onPageChanged(int index) {
    if (index != _currentPageIndex) {
      setState(() {
        _allowPrevious = true;
      });
    }

    if (_currentPageIndex < _videoControllers.length) {
      _videoControllers[_currentPageIndex].pause();
    }

    setState(() {
      _currentPageIndex = index;
      _currentTasteCoin = _feedbacks[index].tasteCoin;
    });

    if (_feedbacks[index].category == 'video_feedback' &&
        index < _videoControllers.length) {
      _videoControllers[index].play();
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    for (var controller in _videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Widget _buildMediaContent(UploadFeedbackModel feedback, int index) {
    if (feedback.category == 'video_feedback') {
      return _buildVideoPlayer(index);
    } else if (feedback.category == 'text_feedback') {
      return _buildTextFeedbackDisplay(feedback);
    }

    return CachedNetworkImage(
      imageUrl: feedback.mediaUrl!,
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

  Widget _buildTextFeedbackDisplay(UploadFeedbackModel feedback) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          if (feedback.branchThumbnail != null)
            Positioned.fill(
              child: CachedNetworkImage(
                imageUrl: feedback.branchThumbnail!,
                fit: BoxFit.cover,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withCustomOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      color: Colors.black.withCustomOpacity(0.2),
                    ),
                  ),
                ),
                placeholder: (context, url) => _buildGradientBackground(),
                errorWidget: (context, url, error) =>
                    _buildGradientBackground(),
              ),
            )
          else
            _buildGradientBackground(),
          Positioned.fill(
            child: Container(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white.withCustomOpacity(0.1),
                      borderRadius: BorderRadius.circular(50),
                      border: Border.all(
                        color: Colors.white.withCustomOpacity(0.2),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.format_quote,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white.withCustomOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withCustomOpacity(0.2),
                        width: 1,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withCustomOpacity(0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          feedback.description,
                          style: AppTextStyles.boldBodyStyle.copyWith(
                            color: Colors.white,
                            fontSize: 18,
                            height: 1.5,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        ...[
                          const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withCustomOpacity(0.2),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              feedback.branchName,
                              style: AppTextStyles.regularStyle.copyWith(
                                color: Colors.white.withCustomOpacity(0.9),
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      3,
                      (index) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: Colors.white.withCustomOpacity(0.6),
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGradientBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF667eea),
            const Color(0xFF764ba2),
            const Color(0xFFf093fb),
            const Color(0xFFf5576c),
          ],
          stops: const [0.0, 0.3, 0.7, 1.0],
        ),
      ),
    );
  }

  Widget _buildVideoPlayer(int index) {
    if (index >= _videoControllers.length ||
        !_videoControllers[index].value.isInitialized) {
      return const Center(
        child: CupertinoActivityIndicator(color: AppColors.whiteColor),
      );
    }

    return GestureDetector(
      onTap: () {
        if (_videoControllers[index].value.isPlaying) {
          _videoControllers[index].pause();
        } else {
          _videoControllers[index].play();
        }
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _videoControllers[index].value.aspectRatio,
            child: VideoPlayer(_videoControllers[index]),
          ),
          if (!_videoControllers[index].value.isPlaying)
            const Icon(
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
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          SvgPicture.asset(AppAssets.coinLogo, width: 24),
          Padding(
            padding: const EdgeInsets.only(top: 18.0, left: 8, right: 12),
            child: Text(
              _currentTasteCoin.toString(),
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
      body: NotificationListener<ScrollNotification>(
        onNotification: (scrollNotification) {
          if (!_allowPrevious &&
              scrollNotification is UserScrollNotification &&
              scrollNotification.direction == ScrollDirection.forward &&
              _pageController.page! > _currentPageIndex) {
            return true;
          }
          return false;
        },
        child: PageView.builder(
          controller: _pageController,
          scrollDirection: Axis.vertical,
          onPageChanged: _onPageChanged,
          itemCount: _feedbacks.length,
          physics: _allowPrevious
              ? const AlwaysScrollableScrollPhysics()
              : const ClampingScrollPhysics(),
          itemBuilder: (context, index) {
            if (!_allowPrevious && index < _currentPageIndex) {
              return Container();
            }

            final feedback = _feedbacks[index];
            return Stack(
              children: [
                Positioned.fill(child: _buildMediaContent(feedback, index)),
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.transparent,
                          Colors.black.withCustomOpacity(0.7),
                        ],
                        stops: const [0.0, 0.6, 1.0],
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Spacer(),
                    LikesInteraction(
                      userRole: widget.userRole,
                      feedback: feedback,
                      feedbackScope: widget.feedbackScope,
                      commentSheet: () {
                        CommentsBottomSheet(
                          feedbackId: feedback.feedbackId,
                          onCommentAdded: () {
                            controller
                                .getFreshFeedback(feedback.feedbackId)
                                .then((freshFeedback) {
                              if (mounted) {
                                setState(() {
                                  _feedbacks[index] = freshFeedback;
                                  _currentTasteCoin = freshFeedback.tasteCoin;
                                });
                              }
                            });
                          },
                        ).show(context);
                      },
                    ),
                    Container(
                      padding: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withCustomOpacity(0.5),
                          ],
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: SafeArea(
                          child: UserInfoWidget(
                            userId: feedback.userId,
                            feedback: feedback,
                            controller: controller,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
