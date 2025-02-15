import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../../config/app_text_styles.dart';
import '../../../../../constant/app_colors.dart';
import '../branches_list_controller.dart';

class SelectedIndex extends StatelessWidget {
  const SelectedIndex({
    super.key,
    required this.controller,
  });

  final BranchesListController controller;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 50, // Set a fixed height for ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                return Obx(() => GestureDetector(
                      onTap: () => controller.changeCategory(index),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            vertical: 12, horizontal: 16),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          color: controller.selectedIndex.value == index
                              ? AppColors.primaryColor // Active color
                              : AppColors.textColor
                                  .withCustomOpacity(0.1), // Default color
                        ),
                        child: Text(
                          controller.categories[index],
                          style: AppTextStyles.boldBodyStyle.copyWith(
                            color: controller.selectedIndex.value == index
                                ? Colors.white // Active text color
                                : AppColors.textColor.withCustomOpacity(
                                    0.7), // Default text color
                          ),
                        ),
                      ),
                    ));
              },
            ),
          ),
        ),
      ],
    );
  }
}
