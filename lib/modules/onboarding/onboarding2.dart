import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/core/widgets/onboarding_elevatedbutton.dart';
import 'package:tasteclip/theme/gradient.dart';
import 'package:tasteclip/theme/text_style.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    vision,
                    height: 250,
                    width: 250,
                  ),
                ),
                Text('Our Vision', style: AppTextStyles.style4),
                SizedBox(height: Get.height * 0.02),
                Center(
                  child: Text(
                    'We are on a mission to empower your voice. Join us in shaping better dining experiences together.',
                    style: AppTextStyles.style5,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Spacer(),
                const OnboardingElevatedButton(),
                SizedBox(height: Get.height * 0.02)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
