import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/modules/redeem/redeem_coin_screen.dart';
import 'package:tasteclip/modules/review/Image/model/upload_feedback_model.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

class LikesInteraction extends StatefulWidget {
  const LikesInteraction({
    super.key,
    required this.feedback,
    required this.feedbackScope,
    required this.commentSheet,
    this.userRole,
  });
  final FeedbackScope feedbackScope;
  final UserRole? userRole;
  final UploadFeedbackModel feedback;
  final VoidCallback commentSheet;

  @override
  LikesInteractionState createState() => LikesInteractionState();
}

class LikesInteractionState extends State<LikesInteraction> {
  final controller = Get.find<WatchFeedbackController>();
  final userProfileController = Get.put(UserProfileController());

  late Future<Map<String, int>> _feedbackCountsFuture;
  late Future<AuthModel?> _userFuture;

  bool _isLiked = false;
  int _likeCount = 0;
  int _commentCount = 0;
  bool _isLikeActionInProgress = false;

  @override
  void initState() {
    super.initState();
    _initializeData();
    controller.addListener(_updateCounts);

    controller.addListener(_updateLikeState);
  }

  void _updateCounts() {
    final updatedFeedback = controller.feedbacks.firstWhere(
      (f) => f.feedbackId == widget.feedback.feedbackId,
      orElse: () => widget.feedback,
    );

    if (mounted) {
      setState(() {
        _isLiked = controller.isLikedByCurrentUser(updatedFeedback);
        _likeCount = updatedFeedback.likes.length;
        _commentCount = updatedFeedback.comments.length;
      });
    }
  }

  void _initializeData() {
    _feedbackCountsFuture = _fetchUserFeedbackCounts(widget.feedback.userId);
    _userFuture = controller.getUserDetails(widget.feedback.userId);

    final currentFeedback = controller.feedbacks.firstWhere(
      (f) => f.feedbackId == widget.feedback.feedbackId,
      orElse: () => widget.feedback,
    );

    _isLiked = controller.isLikedByCurrentUser(currentFeedback);
    _likeCount = currentFeedback.likes.length;
    _commentCount = currentFeedback.comments.length;
  }

  @override
  void didUpdateWidget(LikesInteraction oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.feedback.feedbackId != widget.feedback.feedbackId) {
      _initializeData();
    }
  }

  @override
  void dispose() {
    controller.removeListener(_updateCounts);

    controller.removeListener(_updateLikeState);
    super.dispose();
  }

  void _updateLikeState() {
    final updatedFeedback = controller.feedbacks.firstWhere(
      (f) => f.feedbackId == widget.feedback.feedbackId,
      orElse: () => widget.feedback,
    );

    if (mounted) {
      setState(() {
        _isLiked = controller.isLikedByCurrentUser(updatedFeedback);
        _likeCount = updatedFeedback.likes.length;
      });
    }
  }

  Future<Map<String, int>> _fetchUserFeedbackCounts(String userId) async {
    try {
      final textSnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: 'text_feedback')
          .count()
          .get();

      final imageSnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: 'image_feedback')
          .count()
          .get();

      final videoSnapshot = await FirebaseFirestore.instance
          .collection('feedback')
          .where('userId', isEqualTo: userId)
          .where('category', isEqualTo: 'video_feedback')
          .count()
          .get();

      return {
        'text': textSnapshot.count ?? 0,
        'image': imageSnapshot.count ?? 0,
        'video': videoSnapshot.count ?? 0,
      };
    } catch (e) {
      log('Error fetching user feedback counts: $e');
      return {
        'text': 0,
        'image': 0,
        'video': 0,
      };
    }
  }

  Future<void> _handleLike() async {
    if (_isLikeActionInProgress) return;
    _isLikeActionInProgress = true;

    final previousIsLiked = _isLiked;
    final previousLikeCount = _likeCount;

    setState(() {
      _isLiked = !_isLiked;
      _likeCount = _isLiked ? _likeCount + 1 : _likeCount - 1;
    });

    try {
      await controller.toggleLike(widget.feedback.feedbackId);

      final freshFeedback =
          await controller.getFreshFeedback(widget.feedback.feedbackId);
      if (mounted) {
        setState(() {
          _isLiked = controller.isLikedByCurrentUser(freshFeedback);
          _likeCount = freshFeedback.likes.length;
        });
      }
    } catch (e) {
      setState(() {
        _isLiked = previousIsLiked;
        _likeCount = previousLikeCount;
      });

      Get.snackbar(
        'Error',
        'Failed to update like',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      _isLikeActionInProgress = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, int>>(
      future: _feedbackCountsFuture,
      builder: (context, snapshot) {
        final counts = snapshot.data ?? {'text': 0, 'image': 0, 'video': 0};

        return Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.greyColor.withCustomOpacity(.3),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),
          child: Column(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                spacing: 6,
                children: [
                  GestureDetector(
                    onTap: _handleLike,
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
                        colorFilter: const ColorFilter.mode(
                          Colors.white,
                          BlendMode.srcIn,
                        ),
                        _isLiked ? AppAssets.likeThumb : AppAssets.likeBorder,
                      ),
                    ),
                  ),
                  Text(
                    _likeCount.toString(),
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  6.vertical,
                  GestureDetector(
                    onTap: widget.commentSheet,
                    child: SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                      AppAssets.message,
                    ),
                  ),
                  Text(
                    _commentCount.toString(),
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  6.vertical,
                  GestureDetector(
                    onTap: widget.userRole == UserRole.manager
                        ? showBillDialog
                        : _showReportDialog,
                    child: SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                      widget.userRole == UserRole.manager
                          ? AppAssets.billIcon
                          : AppAssets.reportIcon,
                    ),
                  ),
                  Text(
                    widget.userRole == UserRole.manager ? "Bill" : "Report",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                  6.vertical,
                  GestureDetector(
                    onTap: () => _showInfoBottomSheet(context, counts),
                    child: SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                      AppAssets.info,
                    ),
                  ),
                  Text(
                    "Info",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _showInfoBottomSheet(BuildContext context, Map<String, int> counts) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.textColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      builder: (context) {
        return FutureBuilder<AuthModel?>(
          future: _userFuture,
          builder: (context, snapshot) {
            final user = snapshot.data;

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 4,
                      width: 40,
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor.withCustomOpacity(0.5),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  16.vertical,
                  Row(
                    children: [
                      ProfileImageWithShimmer(
                        imageUrl: user?.profileImage,
                        radius: 20,
                      ),
                      12.horizontal,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user?.fullName ?? 'Loading...',
                            style: AppTextStyles.regularStyle.copyWith(
                              color: AppColors.whiteColor,
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                          4.vertical,
                          Text(
                            controller.formatDate(widget.feedback.createdAt),
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.whiteColor.withCustomOpacity(.8),
                              fontFamily: AppFonts.sandSemiBold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  16.vertical,
                  Divider(
                    color: AppColors.btnUnSelectColor,
                  ),
                  12.vertical,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        spacing: 6,
                        children: [
                          Text(
                            counts['text'].toString(),
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                              fontFamily: AppFonts.sandBold,
                            ),
                          ),
                          Text(
                            "Text",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 6,
                        children: [
                          Text(
                            counts['image'].toString(),
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                              fontFamily: AppFonts.sandBold,
                            ),
                          ),
                          Text(
                            "Image",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        spacing: 6,
                        children: [
                          Text(
                            counts['video'].toString(),
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                              fontFamily: AppFonts.sandBold,
                            ),
                          ),
                          Text(
                            "Video",
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  12.vertical,
                  Divider(
                    color: AppColors.btnUnSelectColor,
                  ),
                  16.vertical,
                  widget.feedbackScope == FeedbackScope.currentUserFeedback
                      ? SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            onPressed: () => widget.feedbackScope ==
                                    FeedbackScope.currentUserFeedback
                                ? Get.to(() =>
                                    RedeemCoinScreen(feedback: widget.feedback))
                                : Navigator.pop(context),
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 55),
                              backgroundColor: AppColors.mainColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Text(
                              'Redeem Coin',
                              style: AppTextStyles.boldBodyStyle.copyWith(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox.shrink()
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showReportDialog() {
    final reportController = TextEditingController();
    Get.dialog(
      AlertDialog(
        backgroundColor: AppColors.textColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Report Feedback',
          style: AppTextStyles.boldBodyStyle.copyWith(
            color: AppColors.whiteColor,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Please specify the reason for reporting this feedback',
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.whiteColor.withCustomOpacity(0.8),
              ),
            ),
            16.vertical,
            TextField(
              controller: reportController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Enter reason...',
                hintStyle: AppTextStyles.regularStyle.copyWith(
                  color: AppColors.whiteColor.withCustomOpacity(0.5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.whiteColor.withCustomOpacity(0.3),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: AppColors.whiteColor.withCustomOpacity(0.3),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: AppColors.mainColor,
                  ),
                ),
              ),
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(
              'Cancel',
              style: AppTextStyles.regularStyle.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.mainColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () async {
              if (reportController.text.trim().isEmpty) {
                Get.snackbar(
                  'Error',
                  'Please enter a reason for reporting',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              try {
                final currentUser = FirebaseAuth.instance.currentUser;
                if (currentUser == null) return;

                final reportData = {
                  'userId': currentUser.uid,
                  'reason': reportController.text.trim(),
                  'timestamp': DateTime.now().toIso8601String(),
                  'status': ReportStatus.pending.toString(),
                  'sender': UserRole.manager.value
                };

                final doc = await FirebaseFirestore.instance
                    .collection('feedback')
                    .doc(widget.feedback.feedbackId)
                    .get();

                final List<dynamic> existingReports =
                    doc.data()?['report'] ?? [];

                existingReports.add(reportData);

                await FirebaseFirestore.instance
                    .collection('feedback')
                    .doc(widget.feedback.feedbackId)
                    .update({
                  'report': existingReports,
                });

                Get.back();
                Get.snackbar(
                  'Success',
                  'Report submitted successfully',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                );
              } catch (e) {
                log('Error submitting report: $e');
                Get.snackbar(
                  'Error',
                  'Failed to submit report',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
              }
            },
            child: Text(
              'Submit',
              style: AppTextStyles.boldBodyStyle.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void showBillDialog() {
    final reportController = TextEditingController();
    bool isReporting = false;

    Get.dialog(
      StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            backgroundColor: AppColors.textColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Text(
              isReporting ? 'Report Feedback' : 'Branch Bill',
              style: AppTextStyles.boldBodyStyle.copyWith(
                color: AppColors.whiteColor,
              ),
            ),
            content: isReporting
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Please specify the reason for reporting this feedback',
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor.withCustomOpacity(0.8),
                        ),
                      ),
                      16.vertical,
                      TextField(
                        controller: reportController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          hintText: 'Enter reason...',
                          hintStyle: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.whiteColor.withCustomOpacity(0.5),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  AppColors.whiteColor.withCustomOpacity(0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide(
                              color:
                                  AppColors.whiteColor.withCustomOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(
                              color: AppColors.mainColor,
                            ),
                          ),
                        ),
                        style: AppTextStyles.regularStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ],
                  )
                : CachedNetworkImage(
                    fit: BoxFit.cover,
                    imageUrl: widget.feedback.billImageUrl,
                    placeholder: (context, url) => const Center(
                        child: CupertinoActivityIndicator(
                      color: AppColors.whiteColor,
                    )),
                    errorWidget: (context, url, error) => Center(
                        child: Icon(
                      Icons.error,
                      color: AppColors.whiteColor,
                    )),
                  ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: Text(
                  'Cancel',
                  style: AppTextStyles.regularStyle.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.mainColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () async {
                  if (isReporting) {
                    if (reportController.text.trim().isEmpty) {
                      Get.snackbar(
                        'Error',
                        'Please enter a reason for reporting',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                      return;
                    }

                    try {
                      final currentUser = FirebaseAuth.instance.currentUser;
                      if (currentUser == null) return;

                      final reportData = {
                        'userId': currentUser.uid,
                        'reason': reportController.text.trim(),
                        'timestamp': DateTime.now().toIso8601String(),
                        'status': ReportStatus.pending.toString(),
                        'sender': UserRole.manager.value
                      };

                      final doc = await FirebaseFirestore.instance
                          .collection('feedback')
                          .doc(widget.feedback.feedbackId)
                          .get();

                      final List<dynamic> existingReports =
                          doc.data()?['report'] ?? [];

                      existingReports.add(reportData);

                      await FirebaseFirestore.instance
                          .collection('feedback')
                          .doc(widget.feedback.feedbackId)
                          .update({
                        'report': existingReports,
                      });

                      Get.back();
                      Get.snackbar(
                        'Success',
                        'Report submitted successfully',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.green,
                        colorText: Colors.white,
                      );
                    } catch (e) {
                      log('Error submitting report: $e');
                      Get.snackbar(
                        'Error',
                        'Failed to submit report',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  } else {
                    setState(() {
                      isReporting = true;
                    });
                  }
                },
                child: Text(
                  isReporting ? 'Submit' : 'Report',
                  style: AppTextStyles.boldBodyStyle.copyWith(
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
