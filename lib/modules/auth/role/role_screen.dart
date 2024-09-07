import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';

import '../../../widgets/or_continue_with.dart';

class RoleScreen extends StatelessWidget {
  const RoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              60.vertical,
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Welcome to\nTaste Clip',
                          style: AppTextStyles.mediumStyle,
                          textAlign: TextAlign.center,
                        ),
                        40.vertical,
                        Image.asset(
                          AppAssets.appLogo,
                          width: 200,
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Get Started with...',
                            style: AppTextStyles.semiBoldStyle,
                          ),
                        ),
                        14.vertical,
                        AppButton(
                          text: 'User',
                          onPressed: () {},
                        ),
                        15.vertical,
                        AppButton(
                          text: 'Guest',
                          onPressed: () {},
                        ),
                        30.vertical,
                        const OrContinueWith(),
                      ],
                    ),
                  ),
                ),
              ),
              12.vertical,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: AppButton(
                  isGradient: false,
                  btnColor: AppColors.primaryColor,
                  text: 'Restaurant Manager',
                  onPressed: () {},
                ),
              ),
              30.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
