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
    return Padding(
      padding: const EdgeInsets.only(left: 12),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 34,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, index) {
                  return Obx(() => GestureDetector(
                        onTap: () => controller.changeCategory(index),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 12),
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: controller.selectedIndex.value == index
                                ? AppColors.mainColor
                                : AppColors.textColor.withCustomOpacity(0.1),
                          ),
                          child: Text(
                            controller.categories[index],
                            style: AppTextStyles.regularStyle.copyWith(
                              color: controller.selectedIndex.value == index
                                  ? Colors.white
                                  : AppColors.textColor.withCustomOpacity(0.7),
                            ),
                          ),
                        ),
                      ));
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
