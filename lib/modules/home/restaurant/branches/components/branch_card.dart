import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_text_styles.dart' show AppTextStyles;
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/home/restaurant/branches/branch_detail/branch_detail_screen.dart';

import '../../../../../core/constant/app_colors.dart';
import '../branches_list_controller.dart';

class BranchCard extends StatelessWidget {
  const BranchCard({
    super.key,
    required this.controller,
  });

  final BranchesListController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.8,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        scrollDirection: Axis.vertical,
        itemCount: controller.branches.length,
        itemBuilder: (context, index) {
          var branch = controller.branches[index];
          final List<Color> colorSequence = [
            Colors.redAccent.withCustomOpacity(.5),
            Colors.blueAccent.withCustomOpacity(.5),
            Colors.orangeAccent.withCustomOpacity(.5),
          ];

          final Color containerColor =
              colorSequence[index % colorSequence.length];
          return GestureDetector(
            onTap: () {
              Get.to(
                () => BranchDetailScreen(
                  branchName: branch["channelName"],
                  branchImageUrl: branch["branchThumbnail"],
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: containerColor,
              ),
              child: Column(
                spacing: 16,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.network(
                      branch['branchThumbnail'],
                      height: 60,
                      width: 60,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      branch["channelName"],
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 8, horizontal: 14),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        color: AppColors.whiteColor,
                      ),
                      child: Text(
                        "View branch",
                        style: AppTextStyles.lightStyle.copyWith(
                          color: AppColors.textColor,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
