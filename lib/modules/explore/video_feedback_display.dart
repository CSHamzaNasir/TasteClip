import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:video_player/video_player.dart';

import 'video_feedback_controller.dart';

class VideoFeedbackDisplay extends StatelessWidget {
  final VideoFeedbackController _controller =
      Get.put(VideoFeedbackController());

  VideoFeedbackDisplay({super.key});

  void _showEndOfListPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.video_library, size: 50, color: Colors.blue),
              SizedBox(height: 16),
              Text(
                "No More Videos",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                "You've reached the end of the feedback list.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text("OK"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_controller.isLoading.value) {
        return Center(child: CupertinoActivityIndicator());
      }

      if (_controller.videoFeedbacks.isEmpty) {
        return Center(child: Text('No video feedbacks available.'));
      }

      return Stack(
        children: [
          PageView.builder(
            scrollDirection: Axis.vertical,
            itemCount: _controller.videoFeedbacks.length + 1,
            itemBuilder: (context, index) {
              if (index == _controller.videoFeedbacks.length) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  _showEndOfListPopup(context);
                });
                return Container();
              }

              final feedback = _controller.videoFeedbacks[index];
              return VideoFeedbackItem(feedback: feedback);
            },
          ),
        ],
      );
    });
  }
}

class VideoFeedbackItem extends StatefulWidget {
  final Map<String, dynamic> feedback;

  const VideoFeedbackItem({super.key, required this.feedback});

  @override
  VideoFeedbackItemState createState() => VideoFeedbackItemState();
}

class VideoFeedbackItemState extends State<VideoFeedbackItem> {
  late VideoPlayerController _videoController;
  late Future<void> _initializeVideoPlayerFuture;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _videoController =
        // ignore: deprecated_member_use
        VideoPlayerController.network(widget.feedback['mediaUrl']);
    _initializeVideoPlayerFuture = _videoController.initialize().then((_) {
      setState(() {
        _isPlaying = true;
        _videoController.play();
      });
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_videoController.value.isPlaying) {
        _videoController.pause();
        _isPlaying = false;
      } else {
        _videoController.play();
        _isPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _initializeVideoPlayerFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return SizedBox.expand(
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: _videoController.value.size.width,
                      height: _videoController.value.size.height,
                      child: VideoPlayer(_videoController),
                    ),
                  ),
                );
              } else {
                return Center(
                  child: CupertinoActivityIndicator(
                    color: AppColors.primaryColor,
                  ),
                );
              }
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 100, horizontal: 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppColors.primaryColor.withCustomOpacity(0.8),
                    AppColors.primaryColor.withCustomOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5,
                children: [
                  Text(widget.feedback['description'],
                      style: AppTextStyles.headingStyle1
                          .copyWith(color: AppColors.whiteColor)),
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: AppColors.mainColor),
                    child: Text(widget.feedback['restaurantName'],
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.lightColor,
                        )),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: IconButton(
              icon: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  key: ValueKey<bool>(_isPlaying),
                  color: Colors.white,
                  size: 30,
                ),
              ),
              onPressed: _togglePlayPause,
            ),
          ),
        ],
      ),
    );
  }
}
