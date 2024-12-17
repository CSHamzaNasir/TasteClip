import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/views/channel/profile/channel_profile_controller.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_button.dart';
import 'components/user_profile_card.dart';

class ChannelProfileScreen extends StatelessWidget {
  ChannelProfileScreen({super.key});
  final controller = Get.put(ChannelProfileController());
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    // Adjust spacing dynamically based on screen height
    final double cardSpacing = screenHeight < 600 ? 8.0 : 16.0;

    return AppBackground(
      isLight: true,
      child: SafeArea(
        top: false,
        child: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            AppAssets.channelbgImg,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: 80,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.whiteColor, width: 1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  width: 72,
                                  AppAssets.cheeziousLogo,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 180,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'User Profile',
                                style: AppTextStyles.boldBodyStyle.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 200,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'johndoe@mail.com',
                                style: AppTextStyles.bodyStyle.copyWith(
                                    color:
                                        AppColors.whiteColor.withOpacity(.8)),
                              ),
                            ),
                          ),
                          // Positioned(
                          //   bottom: -165,
                          //   left: 0,
                          //   right: 0,
                          //   child: Padding(
                          //     padding: EdgeInsets.symmetric(
                          //         horizontal: screenWidth * 0.05),
                          //     child: UserProfileCard(
                          //       title1: 'Edit Profile',
                          //       title2: 'Subscription Tracker',
                          //       image1: AppAssets.appLogo,
                          //       image2: AppAssets.appLogo,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.01),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: UserProfileCard(
                          title1: 'Edit Profile',
                          title2: 'Create Event',
                          image1: AppAssets.profileEdit,
                          image2: AppAssets.appLogo,
                        ),
                      ),
                      SizedBox(height: cardSpacing),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: UserProfileCard(
                          title1: 'Add Products',
                          title2: 'Dashboard',
                          image1: AppAssets.appLogo,
                          image2: AppAssets.appLogo,
                        ),
                      ),
                      SizedBox(height: cardSpacing),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: UserProfileCard(
                          title1: 'Theme',
                          title2: 'Logout',
                          image1: AppAssets.appLogo,
                          image2: AppAssets.appLogo,
                        ),
                      ),
                      SizedBox(height: cardSpacing),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(
                  text: "Logout",
                  onPressed: controller.goToRoleScreen,
                ),
              ),
              20.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
