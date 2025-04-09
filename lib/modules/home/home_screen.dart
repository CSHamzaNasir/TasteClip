import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_enum.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/explore/components/image_feedback_display.dart';
import 'package:tasteclip/modules/home/home_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../widgets/under_dev.dart';
import 'components/content_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final controller = Get.put(HomeController());
  final userController = Get.find<UserController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          key: _scaffoldKey,
          drawer: Drawer(
            child: DrawerWidget(),
          ),
          appBar: AppBar(
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${controller.getGreeting()} 👋",
                  style: AppTextStyles.lightStyle.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
                Text(
                  userController.fullName.value,
                  style: AppTextStyles.boldBodyStyle.copyWith(
                    color: AppColors.mainColor,
                  ),
                ),
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
          body: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0).copyWith(top: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Stories",
                  style: AppTextStyles.boldBodyStyle.copyWith(
                    color: AppColors.textColor,
                    fontFamily: AppFonts.sandBold,
                  ),
                ),
                24.vertical,
                Expanded(
                  child: ImageFeedbackDisplay(
                    feedback: FeedbackScope.allFeedback,
                    category: FeedbackCategory.image,
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    AppString.explore,
                    style: AppTextStyles.headingStyle1.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ),
                8.vertical,
                HomeContentCard(
                  onTap: () => showUnderDevelopmentDialog(
                      context, "This feature is under development."),
                  width: 1,
                  imageIcon: AppAssets.shineStar,
                  title: AppString.clickHereForEssentailFood,
                ),
                16.vertical,
                Row(
                  children: [
                    Expanded(
                      child: HomeContentCard(
                        onTap: controller.goToWatchFeedbackScreen,
                        imageIcon: AppAssets.shineStar,
                        title: AppString.watchFeedback,
                      ),
                    ),
                    12.horizontal,
                    Expanded(
                      child: HomeContentCard(
                        onTap: () => controller.goToAllRegisterScreen(),
                        imageIcon: AppAssets.shineStar,
                        title: AppString.exploreRestaurant,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 250,
          child: DrawerHeader(
            decoration: BoxDecoration(),
            child: SingleChildScrollView(
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.mainColor),
                    ),
                    child: ProfileImageWithShimmer(
                      radius: 60,
                      imageUrl: UserController.to.userProfileImage.value,
                    ),
                  ),
                  Text(
                    UserController.to.fullName.value,
                    style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandSemiBold),
                  ),
                  Text(
                    UserController.to.userEmail.value,
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
