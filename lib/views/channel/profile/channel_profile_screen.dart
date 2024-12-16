import 'package:flutter/material.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_text_styles.dart';
import '../../../constant/app_colors.dart';
import '../../../widgets/app_background.dart';
import '../../../widgets/app_button.dart';
import 'components/user_profile_card.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

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
                            AppAssets.dummyImg,
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
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.mainColor, width: 1),
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Image.asset(
                                  width: 72,
                                  AppAssets.dummyImg,
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
                                style: AppTextStyles.bodyStyle.copyWith(
                                  color: AppColors.primaryColor,
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
                                  color: AppColors.primaryColor,
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: -65,
                            left: 0,
                            right: 0,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05),
                              child: UserProfileCard(
                                title1: 'Edit Profile',
                                title2: 'Subscription Tracker',
                                image1: AppAssets.appLogo,
                                image2: AppAssets.appLogo,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: screenHeight * 0.1),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: UserProfileCard(
                          title1: 'Notifications',
                          title2: 'Settings',
                          image1: AppAssets.appLogo,
                          image2: AppAssets.appLogo,
                        ),
                      ),
                      SizedBox(height: cardSpacing),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.05),
                        child: UserProfileCard(
                          title1: 'Working History',
                          title2: 'Switch role',
                          image1: AppAssets.appLogo,
                          image2: AppAssets.appLogo,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(
                  text: "Logout",
                  onPressed: () {},
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
