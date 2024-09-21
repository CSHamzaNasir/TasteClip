import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/modules/splash/onboarding/onboarding_controller.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';

import '../../../config/app_text_styles.dart';
import '../../../widgets/app_button.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({super.key});
  final controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(body: GetBuilder<OnboardingController>(builder: (_) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                38.vertical,
                controller.selectedPage == 0
                    ? Align(
                        alignment: Alignment.centerRight,
                        child: SizedBox(
                          height: 30,
                          width: 80,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.mainColor),
                            onPressed: () =>
                                controller.goToRoleScreen(isSkip: true),
                            child: Text(
                              AppString.skip,
                              style: AppTextStyles.thinStyle.copyWith(
                                color: AppColors.lightColor,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView.builder(
                          controller: controller.pageController,
                          onPageChanged: (value) =>
                              controller.onPageChanged(value),
                          itemBuilder: (context, index) {
                            return controller.onboardingWidgets[index];
                          },
                          itemCount: controller.onboardingWidgets.length,
                        ),
                      ),
                    ],
                  ),
                ),
                controller.selectedPage == 2
                    ? AppButton(
                        btnRadius: 100,
                        text: AppString.getStarted,
                        onPressed: () =>
                            controller.goToRoleScreen(isSkip: false),
                      )
                    : GetBuilder<OnboardingController>(
                        builder: (_) {
                          if (controller.selectedPage == 2) {
                            return const SizedBox.shrink();
                          }
                          return Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: controller.selectedPage == 1
                                ? [
                                    const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                    12.horizontal,
                                    SvgPicture.asset(
                                      AppAssets.coinLogo,
                                      width: 20,
                                    ),
                                  ]
                                : [
                                    SvgPicture.asset(
                                      AppAssets.coinLogo,
                                      width: 20,
                                    ),
                                    12.horizontal,
                                    const CircleAvatar(
                                      radius: 10,
                                      backgroundColor: AppColors.primaryColor,
                                    ),
                                  ],
                          );
                        },
                      ),
                30.vertical,
              ],
            ),
          );
        })),
      ),
    );
  }
}
