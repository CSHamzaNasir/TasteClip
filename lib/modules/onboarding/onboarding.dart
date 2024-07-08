import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/core/widgets/onboarding_button.dart';
import 'package:tasteclip/core/widgets/onboarding_icon.dart';
import 'package:tasteclip/theme/style.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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
                  welcome,
                  height: 250,
                  width: 250,
                ),
              ),
              const Spacer(),
              Text('Welcome to TasteClip', style: AppTextStyles.style4),
              SizedBox(height: Get.height * 0.02),
              Center(
                child: Text(
                  'Lets make your feedback matter. Get started in seconds and share your experiences effortlessly.',
                  style: AppTextStyles.style5,
                  textAlign: TextAlign.center,
                ),
              ),
              const Spacer(),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Step 1 of 3', style: AppTextStyles.style7),
                    SizedBox(width: Get.width * 0.05),
                    GestureDetector(
                      onTap: () => Get.toNamed('/onboarding1'),
                      child: const OnboardingNextIcon(),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Get.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }
}
