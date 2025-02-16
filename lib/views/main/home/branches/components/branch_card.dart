import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart' show AppTextStyles;
import 'package:tasteclip/config/extensions/space_extensions.dart';

import '../../../../../config/app_assets.dart';
import '../../../../../constant/app_colors.dart';
import '../branches_list_controller.dart';

class BranchCard extends StatelessWidget {
  BranchCard({
    super.key,
    required this.branch,
  });

  final Map<String, dynamic> branch;
  final controller = Get.put(BranchesListController());

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.width * 0.6,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              branch['branchThumbnail'],
              height: Get.height * .35,
              width: Get.width * 0.6,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: Get.height * .35,
            width: Get.width * 0.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.black.withCustomOpacity(0.5),
            ),
          ),
          Positioned(
            top: 12,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Column(
                spacing: 6,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    branch["channelName"],
                    style: AppTextStyles.headingStyle1.copyWith(
                      color: AppColors.whiteColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  4.vertical,
                  Text(
                    "Total reviews: 23",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor.withCustomOpacity(.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    "Total product: 23",
                    style: AppTextStyles.regularStyle.copyWith(
                      color: AppColors.whiteColor.withCustomOpacity(.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: Get.height * .13,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: controller.goToBranchDetailScreen,
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
                            style: AppTextStyles.bodyStyle.copyWith(
                              color: AppColors.textColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: AppColors.whiteColor,
                        ),
                        child: SvgPicture.asset(
                          AppAssets.savedIcon,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
