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
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/explore/detail/components/feedback_item.dart';
import 'package:tasteclip/modules/explore/detail/feedback_detail_screen.dart';
import 'package:tasteclip/modules/explore/watch_feedback_controller.dart';
import 'package:tasteclip/modules/home/chat_bot/welcome_screen.dart';
import 'package:tasteclip/modules/home/components/upload_visual_feedback.dart';
import 'package:tasteclip/modules/home/home_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final userController = Get.find<UserController>();
  final watchFeedbackController = Get.put(WatchFeedbackController());

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          // drawer: HomeDrawer(),
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
                      userController.fullName.value,
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
                child: ProfileImageWithShimmer(
                    imageUrl: userController.userProfileImage.value),
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
              Obx(() {
                if (watchFeedbackController.isLoading.value) {
                  return const Center(child: CupertinoActivityIndicator());
                }

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

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    6.vertical,
                    TextFeedback(),
                    UploadVisualFeedback(),
                    6.vertical,
                    VisualFeedback(),
                  ],
                );
              }),
              Positioned(
                right: 20,
                bottom: MediaQuery.of(context).size.height / 2 - 28,
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => WelcomeScreen());
                  },
                  child: Container(
                    padding: EdgeInsets.all(6),
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
}

class TextFeedback extends StatelessWidget {
  TextFeedback({super.key});

  final watchFeedbackController = Get.find<WatchFeedbackController>();

  @override
  Widget build(BuildContext context) {
    final imageFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.category == 'text_feedback')
        .toList();

    if (imageFeedbacks.isEmpty) {
      return Expanded(
        child: Center(
          child: Text(
            "No Text feedbacks available",
            style: AppTextStyles.regularStyle.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
      );
    }

    return SizedBox(
      height: 140,
      child: ListView.builder(
        itemCount: imageFeedbacks.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final feedback = imageFeedbacks[index];
          return GestureDetector(
            onTap: () => Get.to(() => FeedbackDetailScreen(
                  feedback: feedback,
                  feedbackScope: FeedbackScope.allFeedback,
                )),
            child: FeedbackItem(
              feedback: feedback,
              feedbackScope: FeedbackScope.allFeedback,
            ),
          );
        },
      ),
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
      return Expanded(
        child: Center(
          child: Text(
            "No image feedbacks available",
            style: AppTextStyles.regularStyle.copyWith(
              color: AppColors.textColor,
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: RefreshIndicator(
          onRefresh: () async {
            await watchFeedbackController.refreshFeedbacks();
          },
          child: ListView.builder(
            itemCount: imageFeedbacks.length,
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
        ),
      ),
    );
  }
}
