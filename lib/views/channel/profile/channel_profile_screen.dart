import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/views/auth/role/role_screen.dart';
import 'package:tasteclip/views/main/profile/profile_detail/image_feedback/image_feedback_screen.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../config/role_enum.dart';
import '../../main/profile/profile_detail/text_feedback/text_feedback_screen.dart';
import 'channel_profile_controller.dart';

class ChannelProfileScreen extends StatelessWidget {
  final UserRole role;
  ChannelProfileScreen({super.key, required this.role});

  final controller = Get.put(ChannelProfileController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.transparent,
          elevation: 0,
          title: Row(
            children: [
              Text(
                  role == UserRole.manager ? "Manager Profile" : "User Profile",
                  style: AppTextStyles.bodyStyle.copyWith(
                    color: AppColors.textColor,
                  )),
              Spacer(),
              InkWell(
                  onTap: () => Get.to((RoleScreen())),
                  child: Text(
                    "Log out",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                    ),
                  ))
            ],
          ),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: CircularProgressIndicator())
              : controller.managerData.value == null
                  ? Center(child: Text("No data available"))
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(100),
                                child: Image.asset(
                                  height: 150,
                                  width: 150,
                                  AppAssets.dummyImg,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          16.vertical,
                          Text(
                              controller.managerData.value!['restaurantName']
                                  .toUpperCase(),
                              style: AppTextStyles.boldBodyStyle.copyWith(
                                color: AppColors.textColor,
                              )),
                          6.vertical,
                          Text("@username",
                              style: AppTextStyles.regularStyle
                                  .copyWith(color: AppColors.textColor)),
                          16.vertical,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(
                              controller.feedbackOptions.length,
                              (index) => GestureDetector(
                                onTap: () {
                                  if (index == 0) {
                                    Get.to(() => TextFeedbackScreen(
                                          role: UserRole.manager,
                                        ));
                                  }
                                  if (index == 1) {
                                    Get.to(() => ImageFeedbackScreen(
                                          role: UserRole.manager,
                                        ));
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: AppColors.greyColor,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        controller.feedbackOptions[index]
                                            ['icon'],
                                        height: 24,
                                        width: 24,
                                      ),
                                      SizedBox(height: 12),
                                      RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                              text: '12 ',
                                              style: AppTextStyles.bodyStyle
                                                  .copyWith(
                                                color: AppColors.mainColor,
                                                fontFamily: AppFonts.sandBold,
                                              ),
                                            ),
                                            TextSpan(
                                              text: "posts",
                                              style: AppTextStyles.bodyStyle
                                                  .copyWith(
                                                color: AppColors.mainColor,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          16.vertical,
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: AppColors.primaryColor),
                              color: AppColors.mainColor.withCustomOpacity(.1),
                            ),
                            child: Row(
                              children: [
                                Text(
                                  controller.managerData.value!['branchAddress']
                                      .toLowerCase(),
                                  style: AppTextStyles.bodyStyle.copyWith(
                                    fontFamily: AppFonts.sandSemiBold,
                                    color: AppColors.mainColor,
                                  ),
                                ),
                                Spacer(),
                                SvgPicture.asset(
                                  AppAssets.arrowNext,
                                  width: 24,
                                  height: 24,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.mainColor,
                                    BlendMode.srcIn,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
