import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'channel_hone_controller.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChannelHomeController());

    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                20.vertical,
                Obx(() => Text(
                      controller.restaurantName.isNotEmpty
                          ? controller.restaurantName.value
                          : "Loading...",
                      style: AppTextStyles.boldBodyStyle.copyWith(
                        fontSize: 20,
                        color: AppColors.textColor,
                      ),
                    )),
                10.vertical,
                Obx(() => Text(
                      controller.branchAddress.isNotEmpty
                          ? controller.branchAddress.value
                          : "Loading...",
                      style: AppTextStyles.lightStyle.copyWith(
                        color: AppColors.mainColor,
                      ),
                    )),
                20.vertical,
                Row(
                  children: List.generate(controller.labels.length, (index) {
                    return GetBuilder<ChannelHomeController>(
                      builder: (_) {
                        final isSelected = controller.selectedIndex == index;

                        return GestureDetector(
                          onTap: () => controller.updateIndex(index),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12.0),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.mainColor
                                    : Colors.transparent,
                                border: Border.all(color: AppColors.mainColor),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                controller.labels[index],
                                style: AppTextStyles.bodyStyle.copyWith(
                                  fontFamily: isSelected
                                      ? AppFonts.sandBold
                                      : AppFonts.sandSemiBold,
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.mainColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }),
                ),
                20.vertical,
                Container(
                  padding: EdgeInsets.all(16).copyWith(bottom: 40),
                  decoration: BoxDecoration(
                      color: AppColors.whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        AppAssets.dummyImg,
                        height: 191,
                      ),
                      16.vertical,
                      Text(
                        "Video Title",
                        style: AppTextStyles.boldBodyStyle.copyWith(
                          fontFamily: AppFonts.sandSemiBold,
                          color: AppColors.textColor,
                        ),
                      ),
                      Text(
                        "Branch name",
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      ),
                      Text(
                        "12 min ago",
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.mainColor,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
