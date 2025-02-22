import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';

import '../../../config/app_text_styles.dart';
import '../watch_feedback_controller.dart';

class BottomFilter extends StatelessWidget {
  const BottomFilter({
    super.key,
    required this.controller,
  });

  final WatchFeedbackController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: SizedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.textColor.withCustomOpacity(0.1),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Obx(() => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        List.generate(controller.categories.length, (index) {
                      bool isSelected = controller.selectedIndex.value == index;
                      return GestureDetector(
                        onTap: () => controller.changeCategory(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: isSelected ? AppColors.mainColor : null,
                          ),
                          child: Text(
                            controller.categories[index],
                            style: AppTextStyles.regularStyle.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textColor.withCustomOpacity(0.7),
                            ),
                          ),
                        ),
                      );
                    }),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
