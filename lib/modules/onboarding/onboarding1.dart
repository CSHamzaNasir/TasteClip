import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/core/widgets/onboarding_button.dart';
import 'package:tasteclip/theme/gradient.dart';
import 'package:tasteclip/theme/style.dart';
import 'package:tasteclip/core/widgets/onboarding_icon.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: lightWhiteGradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(height: Get.height * 0.1),
                    const OnBoardingButtton()
                  ],
                ),
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    mission,
                    height: 250,
                    width: 250,
                  ),
                ),
                Text('Our Mission', style: AppTextStyles.style4),
                SizedBox(height: Get.height * 0.02),
                Center(
                  child: Text(
                    'We are on a mission to empower your voice. Join us in shaping better dining experiences together.',
                    style: AppTextStyles.style5,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Step 2 of 3', style: AppTextStyles.style7),
                      SizedBox(width: Get.width * 0.05),
                      GestureDetector(
                          onTap: () => Get.toNamed('/onboarding2'),
                          child: const OnboardingNextIcon())
                    ],
                  ),
                ),
                SizedBox(height: Get.height * 0.02)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
