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
                                child: Obx(() => CircleAvatar(
                                      backgroundColor: AppColors.mainColor,
                                      radius: 40,
                                      backgroundImage: controller
                                              .profileImage.value.isNotEmpty
                                          ? NetworkImage(
                                              controller.profileImage.value)
                                          : null,
                                      child:
                                          controller.profileImage.value.isEmpty
                                              ? const Icon(
                                                  Icons.person,
                                                  size: 50,
                                                )
                                              : null,
                                    )),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 180,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Obx(() => Text(
                                    controller.channelName.isNotEmpty
                                        ? controller.channelName.value
                                        : "Loading...",
                                    style: AppTextStyles.boldBodyStyle.copyWith(
                                      color: AppColors.whiteColor,
                                    ),
                                  )),
                            ),
                          ),
                          Positioned(
                            top: 205,
                            left: 0,
                            right: 0,
                            child: Align(
                              alignment: Alignment.center,
                              child: Obx(() => Text(
                                    controller.email.isNotEmpty
                                        ? controller.email.value
                                        : "Loading...",
                                    style: AppTextStyles.bodyStyle
                                        .copyWith(color: AppColors.whiteColor),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      12.vertical,
                      UserProfileCard(
                        onTap1: () => controller.goToEditScreen(),
                        title1: 'Edit Profile',
                        title2: 'Theme',
                        image1: AppAssets.profileEdit,
                        image2: AppAssets.theme,
                      ),
                      12.vertical,
                      UserProfileCard(
                        title1: 'Legal',
                        title2: 'Help & Support',
                        image1: AppAssets.legal,
                        image2: AppAssets.support,
                      ),
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
