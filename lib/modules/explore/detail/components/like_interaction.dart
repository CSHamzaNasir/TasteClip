import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  });
  final FeedbackScope feedbackScope;
  final UploadFeedbackModel feedback;
  final VoidCallback commentSheet;

  @override
  LikesInteractionState createState() => LikesInteractionState();
}

class LikesInteractionState extends State<LikesInteraction> {
  final controller = Get.find<WatchFeedbackController>();
  final userProfileController = Get.find<UserProfileController>();

  late Future<Map<String, int>> _feedbackCountsFuture;
  late Future<AuthModel?> _userFuture;

  // Local state for instant UI updates
  late bool _isLiked;
  late int _likeCount;
  late int _commentCount;

  @override
  void initState() {
    super.initState();
    _feedbackCountsFuture = _fetchUserFeedbackCounts(widget.feedback.userId);
    _userFuture = controller.getUserDetails(widget.feedback.userId);

    // Initialize local state
    _isLiked = controller.isLikedByCurrentUser(widget.feedback);
    _likeCount = widget.feedback.likes.length;
    _commentCount = widget.feedback.comments.length;
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => widget.feedbackScope ==
                              FeedbackScope.currentUserFeedback
                          ? Get.to(
                              () => RedeemCoinScreen(feedback: widget.feedback))
                          : Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          // padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                      child: Text(
                        widget.feedbackScope ==
                                FeedbackScope.currentUserFeedback
                            ? 'Redeem Coin'
                            : 'Go to profile',
                        style: AppTextStyles.boldBodyStyle.copyWith(
                          color: AppColors.whiteColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
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
                )),
            child: Column(
              spacing: 6,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  spacing: 6,
                  children: [
                    // Like Button
                    GestureDetector(
                      onTap: () async {
                        // Immediate UI update
                        setState(() {
                          _isLiked = !_isLiked;
                          _likeCount =
                              _isLiked ? _likeCount + 1 : _likeCount - 1;
                        });

                        try {
                          await controller
                              .toggleLike(widget.feedback.feedbackId);
                        } catch (e) {
                          // Revert if error occurs
                          setState(() {
                            _isLiked = !_isLiked;
                            _likeCount =
                                _isLiked ? _likeCount + 1 : _likeCount - 1;
                          });
                          log('Error toggling like: $e');
                        }
                      },
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

                    // Comment Button
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

                    // Saved Icon
                    SvgPicture.asset(
                      colorFilter: const ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                      AppAssets.savedIcon,
                    ),
                    Text(
                      counts['image'].toString(),
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.whiteColor,
                      ),
                    ),

                    6.vertical,

                    // Info Button
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
                  ],
                ),
              ],
            ),
          );
        });
  }
}
