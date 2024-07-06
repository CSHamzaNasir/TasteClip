import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tasteclip/widgets/onboarding_button.dart';
import 'package:tasteclip/theme/style.dart';
import 'package:tasteclip/widgets/onboarding_icon.dart';

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
              const Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [OnBoardingButtton()],
              ),
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
              Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Text('Step 1 of 3', style: AppTextStyles.style7),
                SizedBox(width: Get.width * 0.05),
                const OnboardingNextIcon()
              ]),
              SizedBox(height: Get.height * 0.02)
            ],
          ),
        ),
      ),
    );
  }
}
