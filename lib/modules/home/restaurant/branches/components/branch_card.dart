import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart' show AppTextStyles;
import 'package:tasteclip/core/constant/app_fonts.dart';

import '../../../../../core/constant/app_colors.dart';
import '../branches_list_controller.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.controller,
    required this.onBranchSelected,
    required this.selectedBranchId,
  });

  final BranchesListController controller;
  final Function(Map<String, dynamic>) onBranchSelected;
  final String? selectedBranchId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100, // Fixed height for the horizontal list
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.horizontal,
        itemCount: controller.branches.length,
        itemBuilder: (context, index) {
          var branch = controller.branches[index];
          final isSelected = branch['branchId'] == selectedBranchId;

          return GestureDetector(
            onTap: () {
              onBranchSelected(branch);
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.mainColor
                            : Colors.transparent,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(
                        branch['branchThumbnail'],
                        height: 60,
                        width: 60,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: 100,
                    child: Text(
                      branch["branchAddress"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: isSelected
                            ? AppColors.mainColor
                            : AppColors.textColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
