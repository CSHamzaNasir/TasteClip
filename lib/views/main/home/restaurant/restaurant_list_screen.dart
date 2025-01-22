import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';
import 'package:tasteclip/views/main/home/restaurant/restaurant_list_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../../config/app_assets.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(RestaurantListController());

    return AppBackground(
      isLight: true,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              32.vertical,
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        prefixIcon: const Icon(Icons.search),
                      ),
                    ),
                  ),
                  16.horizontal,
                  SvgPicture.asset(
                    AppAssets.filterIcon,
                    height: 50,
                  ),
                ],
              ),
              Expanded(
                child: Obx(() {
                  if (controller.approvedManagers.isEmpty) {
                    return const Center(
                      child: Text("No approved managers available"),
                    );
                  }

                  return ListView.builder(
                    itemCount: controller.approvedManagers.length,
                    itemBuilder: (context, index) {
                      final manager = controller.approvedManagers[index].data()
                          as Map<String, dynamic>?;

                      if (manager == null) {
                        return const SizedBox.shrink();
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 12),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32),
                            color: AppColors.whiteColor,
                            border: Border.all(
                                color: AppColors.primaryColor.withAlpha(110))),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  backgroundColor: AppColors.mainColor,
                                  radius: 40,
                                  backgroundImage: manager["profile_image"] !=
                                          null
                                      ? NetworkImage(manager["profile_image"])
                                      : null,
                                  child: manager["profile_image"] == null
                                      ? const Icon(Icons.person, size: 50)
                                      : null,
                                ),
                                16.horizontal,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      manager["channel_name"] ?? "channel_name",
                                      style:
                                          AppTextStyles.boldBodyStyle.copyWith(
                                        fontFamily: AppFonts.sandSemiBold,
                                        color: AppColors.textColor,
                                      ),
                                    ),
                                    Text(
                                      manager['branch_address'] ?? "No address",
                                      style: AppTextStyles.bodyStyle.copyWith(
                                        color: AppColors.mainColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                                const Spacer(),
                                SvgPicture.asset(
                                  AppAssets.rightArrow,
                                  height: 30,
                                )
                              ],
                            ),
                            16.vertical,
                            InkWell(
                              onTap: () {
                                controller.showFeedbackDialog(
                                    manager["restaurant_name"] ?? "Restaurant");
                              },
                              child: Text(
                                "+Add feedback",
                                style: AppTextStyles.bodyStyle.copyWith(
                                  fontFamily: AppFonts.sandSemiBold,
                                  color: AppColors.textColor.withAlpha(130),
                                ),
                              ),
                            ),
                            6.vertical,
                            Text(
                              manager["restaurant_name"] ?? "No restaurant",
                              style: AppTextStyles.headingStyle1.copyWith(
                                color: AppColors.textColor,
                                fontFamily: AppFonts.sandBold,
                              ),
                            ),
                            6.vertical,
                            Row(
                              children: [
                                const Text("12 Total feedback"),
                                16.horizontal,
                                const Text("3.5 rating"),
                              ],
                            ),
                            12.vertical,
                            Image.asset(
                              AppAssets.feedbackaUser,
                              height: 20,
                            )
                          ],
                        ),
                      );
                    },
                  );
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
