import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/controller/local_user_controller.dart';
import 'package:tasteclip/modules/explore/components/feedback_item.dart'
    as shimmer_widgets;
import 'package:tasteclip/modules/explore/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/controllers/watch_feedback_controller.dart';
import 'package:tasteclip/modules/explore/screens/feedback_detail_screen.dart';
import 'package:tasteclip/modules/home/components/drawer.dart';
import 'package:tasteclip/modules/home/controllers/home_controller.dart';
import 'package:tasteclip/modules/home/modules/chat_bot/screens/welcome_screen.dart';
import 'package:tasteclip/modules/profile/controllers/user_profile_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../explore/components/profile_image_shimmer.dart' as shimmer_widgets;

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final userController = Get.find<UserController>();
  final watchFeedbackController = Get.put(WatchFeedbackController());
  final profileController = Get.put(UserProfileController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          drawer: HomeDrawer(),
          key: _scaffoldKey,
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${controller.getGreeting()} 👋",
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                Obx(() => Text(
                      profileController.fullName.isNotEmpty
                          ? profileController.fullName.value
                          : "Loading...",
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandSemiBold,
                      ),
                    )),
              ],
            ),
            elevation: 0,
            actions: [
              Padding(
                padding: const EdgeInsets.all(8.0).copyWith(right: 12),
                child: Obx(() => shimmer_widgets.ProfileImageWithShimmer(
                      imageUrl: profileController.profileImage.value,
                    )),
              )
            ],
            backgroundColor: AppColors.transparent,
            leading: IconButton(
              icon: SvgPicture.asset(AppAssets.menuIcon),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
          body: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  8.vertical,
                  Expanded(
                    child: Obx(() {
                      if (watchFeedbackController.isLoading.value) {
                        return _buildShimmerLoading();
                      }
                      return CombinedFeedback();
                    }),
                  ),
                ],
              ),
              Positioned(
                right: 20,
                bottom: MediaQuery.of(context).size.height / 2 - 28,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => WelcomeScreen());
                  },
                  child: Container(
                    padding: const EdgeInsets.all(6),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: AppColors.lightColor,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primaryColor.withCustomOpacity(0.4),
                          spreadRadius: 4,
                          blurRadius: 12,
                          offset: Offset.zero,
                        ),
                        BoxShadow(
                          color: Colors.black.withCustomOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 6,
                          offset: Offset.zero,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Image.asset(
                        AppAssets.jinImage,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.builder(
      itemCount: 3,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  shimmer_widgets.ShimmerWidget.circular(
                    width: 40,
                    height: 40,
                  ),
                  8.horizontal,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const shimmer_widgets.ShimmerWidget.rectangular(
                        height: 14,
                        width: 120,
                      ),
                      4.vertical,
                      const shimmer_widgets.ShimmerWidget.rectangular(
                        height: 10,
                        width: 80,
                      ),
                    ],
                  ),
                ],
              ),
              16.vertical,
              const shimmer_widgets.ShimmerWidget.rectangular(
                height: 12,
                width: double.infinity,
              ),
              8.vertical,
              const shimmer_widgets.ShimmerWidget.rectangular(
                height: 12,
                width: 200,
              ),
              16.vertical,
              const shimmer_widgets.ShimmerWidget.rectangular(
                height: 200,
                width: double.infinity,
              ),
            ],
          ),
        );
      },
    );
  }
}

class CombinedFeedback extends StatelessWidget {
  CombinedFeedback({super.key});

  final watchFeedbackController = Get.find<WatchFeedbackController>();

  @override
  Widget build(BuildContext context) {
    if (watchFeedbackController.feedbacks.isEmpty) {
      return Center(
        child: Text(
          "No feedbacks available",
          style: AppTextStyles.regularStyle.copyWith(
            color: AppColors.textColor,
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () async {
        await watchFeedbackController.refreshFeedbacks();
      },
      child: ListView.builder(
        itemCount: watchFeedbackController.feedbacks.length,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemBuilder: (context, index) {
          final feedback = watchFeedbackController.feedbacks[index];

          if (feedback.category == 'video_feedback' &&
              feedback.mediaUrl != null) {
            watchFeedbackController.initializeVideo(
                feedback.feedbackId, feedback.mediaUrl!);
          }

          return GestureDetector(
            onTap: () => Get.to(() => FeedbackDetailScreen(
                  feedback: feedback,
                  feedbackScope: FeedbackScope.allFeedback,
                )),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: FeedbackItem(
                feedback: feedback,
                feedbackScope: FeedbackScope.allFeedback,
              ),
            ),
          );
        },
      ),
    );
  }
}
