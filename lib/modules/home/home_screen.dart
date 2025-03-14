import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/modules/home/home_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../widgets/under_dev.dart';
import 'components/content_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    log("Screen width --------------->>>>>>: $screenWidth");
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
            body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              4.vertical,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      showUnderDevelopmentDialog(
                          context, "This feature is under development.");
                    },
                    icon: const Icon(Icons.menu),
                    color: AppColors.mainColor,
                  ),
                  InkWell(
                    // onTap: controller.goToProfileScreen,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        // Container(
                        //   height: 35,
                        //   width: 115,
                        //   decoration: BoxDecoration(
                        //     color: AppColors.primaryColor,
                        //     borderRadius: BorderRadius.circular(8),
                        //   ),
                        //   child: Center(
                        //       child: Text(
                        //     userData.userName.length > 8
                        //         ? '${userData.userName.substring(0, 8)}...'
                        //         : userData.userName,
                        //     style: AppTextStyles.lightStyle.copyWith(
                        //       color: AppColors.lightColor,
                        //     ),
                        //   )),
                        // ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      showUnderDevelopmentDialog(
                          context, "This feature is under development.");
                    },
                    icon: const Icon(Icons.notifications_outlined),
                    color: AppColors.mainColor,
                  ),
                ],
              ),
              20.vertical,
              Text(
                AppString.capturingExpMotion,
                style: AppTextStyles.headingStyle1.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandBold,
                ),
              ),
              24.vertical,
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
        )),
      ),
    );
  }
}
