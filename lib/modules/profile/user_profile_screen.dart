import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/core/data/models/auth_models.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/profile/edit_profile/user_profile_edit_screen.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart' as shimmer_widgets;
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../config/app_text_styles.dart';
import '../../core/constant/app_colors.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key, this.feedbackScope});
  final controller = Get.put(UserProfileController());
  final watchFeedbackController = Get.put(WatchFeedbackController());
  final FeedbackScope? feedbackScope;

  AuthModel get userData {
    return AuthModel(
      uid: controller.uid.value,
      fullName: controller.fullName.value,
      userName: controller.userName.value,
      email: controller.email.value,
      profileImage: controller.profileImage.value,
    );
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;

    final user = auth.currentUser;
    log(user!.uid);
    final userFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.userId == user.uid)
        .toList();
    final videoFeedbacks = userFeedbacks
        .where((feedback) => feedback.category == 'video_feedback')
        .toList();
    final imageFeedbacks = userFeedbacks
        .where((feedback) => feedback.category == 'image_feedback')
        .toList();
    final textFeedbacks = userFeedbacks
        .where((feedback) => feedback.category == 'text_feedback')
        .toList();
    log(controller.uid.value);
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                child: Image.asset(
                  AppAssets.userBgImg,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
              Transform.translate(
                offset: const Offset(0, -25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: shimmer_widgets.ProfileImageWithShimmer(
                        imageUrl: controller.profileImage.value,
                        radius: 40,
                      ),
                    ),
                    4.vertical,
                    Text(
                      controller.fullName.isNotEmpty
                          ? controller.fullName.value
                          : "Loading...",
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    2.vertical,
                    Text(
                      controller.email.isNotEmpty
                          ? controller.email.value
                          : "Loading...",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.textColor.withCustomOpacity(.6),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: controller.feedbackOptions
                      .map((option) => Column(
                            children: [
                              6.vertical,
                              Text(
                                option['label'],
                                style: AppTextStyles.lightStyle.copyWith(
                                  color:
                                      AppColors.textColor.withCustomOpacity(.7),
                                  fontFamily: AppFonts.sandMedium,
                                ),
                              ),
                              Text(
                                option['count'].toString(),
                                style: AppTextStyles.boldBodyStyle.copyWith(
                                  color: AppColors.textColor,
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              16.vertical,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  spacing: 16,
                  children: [
                    Expanded(
                      child: AppButton(
                        text: "Logout",
                        onPressed: controller.logout,
                        isGradient: false,
                        btnColor: Colors.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.to(() => UserProfileEditScreen()),
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color:
                                    AppColors.mainColor.withCustomOpacity(.5)),
                            borderRadius: BorderRadius.circular(12),
                            color:
                                AppColors.primaryColor.withCustomOpacity(.1)),
                        child: SvgPicture.asset(AppAssets.profileEdit),
                      ),
                    )
                  ],
                ),
              ),
              12.vertical,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (textFeedbacks.isNotEmpty) ...[
                      Text(
                        "Text",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                      16.vertical,
                      SizedBox(
                        height: 155,
                        child: ListView.builder(
                          itemCount: textFeedbacks.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final feedback = textFeedbacks[index];
                            return GestureDetector(
                              onTap: () => Get.to(() => FeedbackDetailScreen(
                                    feedback: feedback,
                                    feedbackScope:
                                        FeedbackScope.currentUserFeedback,
                                  )),
                              child: SizedBox(
                                width: 300,
                                child: FeedbackItem(
                                  feedback: feedback,
                                  feedbackScope: FeedbackScope.allFeedback,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                    if (videoFeedbacks.isNotEmpty) ...[
                      Text(
                        "Stories",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                      16.vertical,
                      SizedBox(
                        height: 150,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await watchFeedbackController.refreshFeedbacks();
                          },
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: videoFeedbacks.length,
                            itemBuilder: (context, index) {
                              final feedback = videoFeedbacks[index];
                              return GestureDetector(
                                onTap: () => Get.to(() => FeedbackDetailScreen(
                                      feedback: feedback,
                                      feedbackScope:
                                          FeedbackScope.currentUserFeedback,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: FeedbackItem(
                                    feedback: feedback,
                                    feedbackScope:
                                        FeedbackScope.currentUserFeedback,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      16.vertical,
                    ],
                    if (imageFeedbacks.isNotEmpty) ...[
                      Text(
                        "Photos",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                      16.vertical,
                      SizedBox(
                        height: 200,
                        child: RefreshIndicator(
                          onRefresh: () async {
                            await watchFeedbackController.refreshFeedbacks();
                          },
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: imageFeedbacks.length,
                            itemBuilder: (context, index) {
                              final feedback = imageFeedbacks[index];
                              return GestureDetector(
                                onTap: () => Get.to(() => FeedbackDetailScreen(
                                      feedback: feedback,
                                      feedbackScope:
                                          FeedbackScope.currentUserFeedback,
                                    )),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 16.0),
                                  child: FeedbackItem(
                                    feedback: feedback,
                                    feedbackScope:
                                        FeedbackScope.currentUserFeedback,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
