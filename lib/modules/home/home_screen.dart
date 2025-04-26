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
import 'package:tasteclip/modules/home/components/drawer.dart';
import 'package:tasteclip/modules/home/home_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
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
          drawer: HomeDrawer(),
          appBar: AppBar(
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.getGreeting()} 👋",
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                Obx(() => Text(
                      userController.fullName.value,
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        color: AppColors.mainColor,
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
          body: Obx(() {
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
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
                  child: Text(
                    AppString.capturingExpMotion,
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                ),
                6.vertical,
                _buildVideoFeedbacks(),
                8.vertical,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "Image Feedbacks",
                    style: AppTextStyles.boldBodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                ),
                16.vertical,
                _buildImageFeedbacks(),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildVideoFeedbacks() {
    final videoFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.category == 'video_feedback')
        .toList();

    if (videoFeedbacks.isEmpty) {
      return const SizedBox.shrink();
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: videoFeedbacks.length,
        itemBuilder: (context, index) {
          final feedback = videoFeedbacks[index];
          return GestureDetector(
            onTap: () => Get.to(() => FeedbackDetailScreen(
                  feedback: feedback,
                  feedbackScope: FeedbackScope.allFeedback,
                )),
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
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

  Widget _buildImageFeedbacks() {
    final imageFeedbacks = watchFeedbackController.feedbacks
        .where((feedback) => feedback.category == 'image_feedback')
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
