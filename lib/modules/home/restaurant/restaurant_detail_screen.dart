import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:get/get.dart';
import 'restaurant_detail_controller.dart';

class RestaurantDetailScreen extends StatelessWidget {
  const RestaurantDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantDetailController());

    return AppBackground(
      isDefault: false,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Row(
                children: [
                  Obx(() {
                    return Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: AppColors.lightColor,
                      ),
                      child: Row(
                        children: List.generate(controller.textOptions.length,
                            (index) {
                          return GestureDetector(
                            onTap: () => controller.selectText(index),
                            child: Container(
                              padding: EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                border: controller.selectedTextIndex.value ==
                                        index
                                    ? Border.all(color: AppColors.primaryColor)
                                    : null,
                                color:
                                    controller.selectedTextIndex.value == index
                                        ? AppColors.primaryColor
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                controller.textOptions[index],
                                style: AppTextStyles.bodyStyle.copyWith(
                                  fontFamily:
                                      controller.selectedTextIndex.value ==
                                              index
                                          ? AppFonts.sandBold
                                          : AppFonts.sandSemiBold,
                                  color: controller.selectedTextIndex.value ==
                                          index
                                      ? AppColors.whiteColor
                                      : AppColors.textColor,
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
