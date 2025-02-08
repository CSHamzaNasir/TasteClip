import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/views/channel/profile/channel_profile_controller.dart';

import '../../../config/app_assets.dart';
import '../../../constant/app_colors.dart';

class ChannelProfileScreen extends StatelessWidget {
  ChannelProfileScreen({super.key});
  final controller = Get.put(ChannelProfileController());
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> branchData = Get.arguments;

    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.whiteColor,
          leading: Icon(
            Icons.arrow_back_ios_rounded,
            size: 18,
            color: AppColors.textColor,
          ),
          title: Text(branchData['restaurantName'],
              style: AppTextStyles.bodyStyle.copyWith(
                  color: AppColors.textColor,
                  fontFamily: AppFonts.sandMedium))),
      backgroundColor: AppColors.whiteColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    50.vertical,
                    Center(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: Image.asset(
                          AppAssets.dummyImg,
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    24.vertical,
                    Text(
                      branchData['restaurantName'],
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.textColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    4.vertical,
                    Text(
                      branchData['channelName'],
                      style: AppTextStyles.regularStyle.copyWith(
                        color: AppColors.textColor,
                      ),
                    ),
                    24.vertical,

                    Row(
                      spacing: 8,
                      children: [
                        Container(
                          height: 94,
                          width: 122,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.textColor.withCustomOpacity(.1)),
                        ),
                        Container(
                          height: 94,
                          width: 122,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.textColor.withCustomOpacity(.1)),
                        ),
                        Container(
                          height: 94,
                          width: 122,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.textColor.withCustomOpacity(.1)),
                        ),
                      ],
                    ),
                    24.vertical,
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: AppColors.textColor.withCustomOpacity(.1)),
                      child: Row(
                        children: [
                          Text(
                            branchData["branchAddress"],
                            style: AppTextStyles.lightStyle.copyWith(
                              color: AppColors.mainColor,
                              fontFamily: AppFonts.sandBold,
                            ),
                          ),
                          Spacer(),
                          SvgPicture.asset(
                            height: 16,
                            AppAssets.arrowRight,
                            colorFilter: ColorFilter.mode(
                              AppColors.mainColor,
                              BlendMode.srcIn,
                            ),
                          )
                        ],
                      ),
                    ),
                    24.vertical,
                    InkWell(
                      onTap: () => controller.goToAllRegisterScreen(),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: AppColors.textColor.withCustomOpacity(.1)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Edit profile",
                              style: AppTextStyles.boldBodyStyle.copyWith(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    // UserProfileCard(
                    //   // onTap1: () => controller.goToEditScreen(),
                    //   title1: 'Edit Profile',
                    //   title2: 'Theme',
                    //   image1: AppAssets.profileEdit,
                    //   image2: AppAssets.theme,
                    // ),
                    // 12.vertical,
                    // UserProfileCard(
                    //   title1: 'Legal',
                    //   title2: 'Help & Support',
                    //   image1: AppAssets.legal,
                    //   image2: AppAssets.support,
                    // ),
                  ],
                ),
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 20.0),
            //   child: AppButton(
            //     text: "Logout", onPressed: () {},
            //     // onPressed: controller.goToRoleScreen,
            //   ),
            // ),
            // 20.vertical,
          ],
        ),
      ),
    );
  }
}
