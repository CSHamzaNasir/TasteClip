import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/widgets/app_background.dart';
import '../../../../constant/app_colors.dart';
import '../../../../config/app_text_styles.dart';
import '../../../../constant/app_fonts.dart';
import 'branches_list_controller.dart';
import 'components/branch_card.dart';
import 'components/selected_index.dart';

class BranchesListScreen extends StatelessWidget {
  final String restaurantId;
  final String restaurantName;

  const BranchesListScreen(
      {super.key, required this.restaurantId, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(BranchesListController());

    controller.fetchBranches(restaurantId);

    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            } else if (controller.hasError.value) {
              return Center(child: Text("Error: ${controller.errorMessage}"));
            } else if (controller.branches.isEmpty) {
              return const Center(child: Text("No branches found."));
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        12.vertical,
                        Row(
                          children: [
                            Image.asset(
                              AppAssets.chatbotIcon,
                              height: 40,
                            ),
                            Spacer(),
                            CircleAvatar(
                              backgroundColor:
                                  AppColors.textColor.withCustomOpacity(.3),
                              child: Icon(
                                Icons.search_rounded,
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        24.vertical,
                        Text(
                          "Find The\nPerfect Choice",
                          style: AppTextStyles.headingStyle.copyWith(
                            color: AppColors.textColor,
                            fontFamily: AppFonts.sandBold,
                          ),
                        ),
                        6.vertical,
                        Text("Discover best choice for you",
                            style: AppTextStyles.bodyStyle
                                .copyWith(color: AppColors.textColor))
                      ],
                    ),
                  ),
                  24.vertical,
                  SelectedIndex(controller: controller),
                  16.vertical,
                  Expanded(
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.branches.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        var branch = controller.branches[index];
                        return BranchCard(branch: branch);
                      },
                    ),
                  ),
                ],
              );
            }
          }),
        ),
      ),
    );
  }
}
