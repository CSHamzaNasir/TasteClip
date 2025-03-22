import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_detail_controller.dart';

import '../../../../../../config/app_text_styles.dart';
import '../../../../../../core/constant/app_colors.dart';

class Filter extends StatelessWidget {
  const Filter({
    super.key,
    required this.controller,
  });

  final BranchDetailController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
                color: AppColors.textColor.withCustomOpacity(0.1),
                borderRadius: BorderRadius.circular(24)),
            height: 30,
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
    );
  }
}
