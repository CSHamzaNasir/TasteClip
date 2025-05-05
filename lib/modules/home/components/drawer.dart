import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          SizedBox(
            height: 250,
            child: DrawerHeader(
              decoration: const BoxDecoration(),
              child: SingleChildScrollView(
                child: Column(
                  spacing: 12,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.mainColor),
                      ),
                      child: Obx(() => ProfileImageWithShimmer(
                            radius: 60,
                            imageUrl: UserController.to.userProfileImage.value,
                          )),
                    ),
                    Obx(() => Text(
                          UserController.to.fullName.value,
                          style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.textColor,
                              fontFamily: AppFonts.sandSemiBold),
                        )),
                    Obx(() => Text(
                          UserController.to.userEmail.value,
                          style: AppTextStyles.regularStyle.copyWith(
                            color: AppColors.textColor,
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
          // ListTile(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Text feedback'),
          //       // SvgPicture.asset(AppAssets.rightArrowIcon),
          //     ],
          //   ),
          //   onTap: () {
          //     // Get.to(() => CompletedOrdersScreen());
          //   },
          // ),
          // ListTile(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Restaurant feedback'),
          //       // SvgPicture.asset(AppAssets.rightArrowIcon),
          //     ],
          //   ),
          //   onTap: () {},
          // ),
          // ListTile(
          //   title: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //     children: [
          //       Text('Find best bite'),
          //       // SvgPicture.asset(AppAssets.rightArrowIcon),
          //     ],
          //   ),
          //   onTap: () {
          //     Get.to(() => const WelcomeScreen());
          //   },
          // ),
        ],
      ),
    );
  }
}
