// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/auth/splash/user_controller.dart';
import 'package:tasteclip/modules/setting/setting_controller.dart';
import 'package:tasteclip/utils/text_shimmer.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

class SettingScreen extends StatelessWidget {
  SettingScreen({super.key});
  final UserController userController = Get.find<UserController>();
  final settingController = Get.put(SettingController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDefault: false,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              size: 18,
              Icons.arrow_back_ios,
            ),
            color: AppColors.textColor,
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: Text(
            "Settings",
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor,
              fontFamily: AppFonts.sandBold,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 24,
                    children: [
                      InkWell(
                        onTap: settingController.goToSettingProfileScreen,
                        child: Container(
                          padding: EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.greyColor.withCustomOpacity(.6),
                          ),
                          child: Row(
                            spacing: 16,
                            children: [
                              ProfileImageWithShimmer(
                                radius: 32,
                                imageUrl:
                                    UserController.to.userProfileImage.value,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                spacing: 4,
                                children: [
                                  Text(
                                    "Profile",
                                    style: AppTextStyles.bodyStyle.copyWith(
                                      color: AppColors.textColor,
                                      fontFamily: AppFonts.sandBold,
                                    ),
                                  ),
                                  Text(
                                    "Profile picture, name",
                                    style: AppTextStyles.lightStyle.copyWith(
                                      color: AppColors.textColor,
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios_outlined,
                                size: 16,
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        spacing: 8,
                        children: [
                          ProfileDetailCard(
                            title: 'My Feedback',
                            description: 'Click here to see details',
                            ontap: () {},
                          ),
                          16.vertical,
                          ProfileDetailCard(
                            title: 'Legal',
                            description: 'Privacy policy, terms of use',
                            ontap: settingController.goToLegalScreen,
                          ),
                          16.vertical,
                          ProfileDetailCard(
                            title: 'Help & Support',
                            description: 'FAQs, contact',
                            ontap: () {},
                          ),
                          16.vertical,
                          ProfileDetailCard(
                            title: 'Your Bookmars',
                            description: 'Click to check your collection',
                            ontap: () {},
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24),
              child: AppButton(
                text: "Logout",
                onPressed: settingController.logout,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ProfileDetailCard extends StatelessWidget {
  final String title;
  final String description;
  final VoidCallback ontap;
  const ProfileDetailCard({
    super.key,
    required this.title,
    required this.description,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Row(
        children: [
          Column(
            spacing: 8,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.regularStyle
                    .copyWith(color: AppColors.textColor),
              ),
              Text(
                description,
                style: AppTextStyles.lightStyle
                    .copyWith(color: AppColors.textColor.withCustomOpacity(.7)),
              ),
            ],
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios_outlined,
            size: 16,
          )
        ],
      ),
    );
  }
}
