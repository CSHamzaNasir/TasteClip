import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/core/constant/app_colors.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/setting/controllers/setting_controller.dart';
import 'package:tasteclip/widgets/app_background.dart';

class LegalScreen extends StatelessWidget {
  LegalScreen({super.key});
  final settingController = Get.find<SettingController>();

  @override
  Widget build(BuildContext context) {
    return AppBackground(
      isLight: true,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(
              size: 18,
              Icons.arrow_back_ios,
            ),
            color: AppColors.textColor,
          ),
          elevation: 0,
          backgroundColor: AppColors.transparent,
          title: Text(
            "Legal",
            style: AppTextStyles.bodyStyle.copyWith(
              color: AppColors.textColor,
              fontFamily: AppFonts.sandBold,
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24),
          child: Column(
            spacing: 32,
            children: [
              Row(
                children: [
                  Text(
                    "Privacy policy",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(AppAssets.rightArrow)
                ],
              ),
              Row(
                children: [
                  Text(
                    "Terms of use",
                    style: AppTextStyles.bodyStyle.copyWith(
                      color: AppColors.textColor,
                      fontFamily: AppFonts.sandBold,
                    ),
                  ),
                  Spacer(),
                  SvgPicture.asset(AppAssets.rightArrow)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
