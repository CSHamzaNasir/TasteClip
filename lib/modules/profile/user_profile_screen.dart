import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../config/app_text_styles.dart';
import '../../core/constant/app_colors.dart';

class UserProfileScreen extends StatelessWidget {
  UserProfileScreen({super.key});
  final controller = Get.put(UserProfileController());
  final watchFeedbackController = Get.put(WatchFeedbackController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                offset: const Offset(0, -40),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        color: AppColors.whiteColor,
                        shape: BoxShape.circle,
                      ),
                      child: ProfileImageWithShimmer(
                        imageUrl: controller.profileImage.value,
                        radius: 40,
                      ),
                    ),
                    4.vertical,
                    GestureDetector(
                      onTap: () {
                        controller.logout();
                      },
                      child: Text(
                        controller.fullName.isNotEmpty
                            ? controller.fullName.value
                            : "Loading...",
                        style: AppTextStyles.bodyStyle.copyWith(
                          color: AppColors.textColor,
                          fontFamily: AppFonts.sandBold,
                        ),
                      ),
                    ),
                    2.vertical,
                    Text(
                      controller.email.isNotEmpty
                          ? controller.email.value
                          : "Loading...",
                      style: AppTextStyles.bodyStyle.copyWith(
                        fontSize: 14,
                        color: AppColors.textColor.withAlpha(200),
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
                            spacing: 6,
                            children: [
                              Text(
                                option['label'],
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.mainColor,
                                  fontFamily: AppFonts.sandBold,
                                ),
                              ),
                              Text(
                                option['count'].toString(),
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.mainColor,
                                ),
                              ),
                            ],
                          ))
                      .toList(),
                ),
              ),
              12.vertical,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Your Feedback",
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Obx(() {
                  if (watchFeedbackController.isLoading.value) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (watchFeedbackController.feedbacks.isEmpty) {
                    return const Center(child: Text('No feedbacks found'));
                  }

                  return GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 10,
                      childAspectRatio: .8,
                    ),
                    padding: const EdgeInsets.all(8),
                    itemCount: watchFeedbackController.feedbacks.length,
                    itemBuilder: (context, index) {
                      final feedback = watchFeedbackController.feedbacks[index];
                      return GestureDetector(
                        onTap: () => Get.to(() => FeedbackDetailScreen(
                              feedback: feedback,
                              feedbackScope: FeedbackScope.currentUserFeedback,
                            )),
                        child: FeedbackItem(
                          feedback: feedback,
                          feedbackScope: FeedbackScope.currentUserFeedback,
                        ),
                      );
                    },
                  );
                }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
