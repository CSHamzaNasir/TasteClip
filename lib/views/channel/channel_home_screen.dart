import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import 'channel_hone_controller.dart';

class ChannelHomeScreen extends StatelessWidget {
  const ChannelHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ChannelHomeController());

    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(3, (index) {
                  final labels = [AppString.videos, "Text", "Images"];

                  return GetBuilder<ChannelHomeController>(
                    builder: (_) {
                      final isSelected = controller.selectedIndex == index;

                      return GestureDetector(
                        onTap: () => controller.updateIndex(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.mainColor
                                : Colors.transparent,
                            border: Border.all(color: AppColors.mainColor),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            labels[index],
                            style: AppTextStyles.bodyStyle.copyWith(
                              fontFamily: isSelected
                                  ? AppFonts.popinsMedium
                                  : AppFonts.popinsRegular,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.mainColor,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
