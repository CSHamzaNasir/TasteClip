import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart'
    as shimmer_widgets;
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/chat_bot/welcome_screen.dart';
import 'package:tasteclip/modules/home/components/drawer.dart';
import 'package:tasteclip/modules/home/components/upload_visual_feedback.dart';
import 'package:tasteclip/modules/home/home_controller.dart';
import 'package:tasteclip/modules/profile/user_profile_controller.dart';
import 'package:tasteclip/modules/review/Image/upload_feedback_screen.dart';
import 'package:tasteclip/widgets/app_background.dart';

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
                  6.vertical,
                  SizedBox(
                    height: 140,
                    child: Obx(() {
                      if (watchFeedbackController.isLoading.value) {
                        return _buildShimmerLoading(isHorizontal: true);
                      }
                      return TextFeedback();
                    }),
                  ),
                  UploadVisualFeedback(),
                  Expanded(
                    child: Obx(() {
                      if (watchFeedbackController.isLoading.value) {
                        return _buildShimmerLoading(isHorizontal: false);
                      }
                      return VisualFeedback();
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

  Widget _buildShimmerLoading({required bool isHorizontal}) {
    if (isHorizontal) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        itemBuilder: (context, index) {
          return Container(
            width: 80,
            margin: const EdgeInsets.only(right: 8, bottom: 20),
            child: const ShimmerWidget.rectangular(
              height: 120,
            ),
          );
        },
      );
    } else {
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
}

class TextFeedback extends StatelessWidget {
  TextFeedback({super.key});

  final watchFeedbackController = Get.find<WatchFeedbackController>();

  @override
  Widget build(BuildContext context) {
    final textFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.category == 'text_feedback')
        .toList();

    return ListView.builder(
      itemCount: textFeedbacks.length + 1,
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            onTap: () => Get.to(
                () => UploadFeedbackScreen(category: FeedbackCategory.text)),
            child: Container(
              width: 80,
              margin: const EdgeInsets.only(right: 8, bottom: 20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                        color: AppColors.whiteColor, style: BorderStyle.solid),
                  ),
                  child: Icon(
                    Icons.add,
                    color: AppColors.whiteColor,
                  ),
                ),
              ),
            ),
          );
        } else {
          final feedback = textFeedbacks[index - 1];
          return GestureDetector(
            onTap: () => Get.to(() => FeedbackDetailScreen(
                  feedback: feedback,
                  feedbackScope: FeedbackScope.allFeedback,
                )),
            child: SizedBox(
              width: 300,
              child: FeedbackItem(
                feedback: feedback,
                feedbackScope: FeedbackScope.allFeedback,
              ),
            ),
          );
        }
      },
    );
  }
}

class VisualFeedback extends StatelessWidget {
  VisualFeedback({super.key});

  final watchFeedbackController = Get.find<WatchFeedbackController>();

  @override
  Widget build(BuildContext context) {
    final imageFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.category != 'text_feedback')
        .toList();

    if (imageFeedbacks.isEmpty) {
      return const SizedBox.shrink();
    }

    return RefreshIndicator(
      onRefresh: () async {
        await watchFeedbackController.refreshFeedbacks();
      },
      child: ListView.builder(
        itemCount: imageFeedbacks.length,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        itemBuilder: (context, index) {
          final feedback = imageFeedbacks[index];
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
