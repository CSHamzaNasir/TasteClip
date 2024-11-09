import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/utils/app_string.dart';
import 'package:tasteclip/widgets/app_background.dart';
import 'package:tasteclip/widgets/app_button.dart';
import 'package:tasteclip/widgets/custom_appbar.dart';

class CompleteProfileScreen extends StatelessWidget {
  const CompleteProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isDark: true,
      child: Scaffold(
        appBar: const CustomAppBar(
          showBackIcon: false,
          isDark: "true",
          title: AppString.createProfile,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppString.completeYourProfile,
                          style: AppTextStyles.bodyStyle.copyWith(
                            color: AppColors.lightColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              AppButton(text: AppString.submit, onPressed: () {}),
              30.vertical,
            ],
          ),
        ),
      ),
    );
  }
}
