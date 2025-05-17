import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/config/extensions/space_extensions.dart';
import 'package:tasteclip/core/constant/app_fonts.dart';
import 'package:tasteclip/modules/profile/controllers/user_profile_controller.dart';
import 'package:tasteclip/widgets/gradient_box.dart';

import '../../../config/app_text_styles.dart';
import '../../../core/constant/app_colors.dart';

class ProfileCard extends StatelessWidget {
  final VoidCallback? onTap;
  final VoidCallback? onTap1;
  final String title;
  final String title1;
  final String subtitle;
  final String subtitle1;
  final String icon;
  final String icon1;
  const ProfileCard({
    super.key,
    required this.controller,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.title1,
    required this.subtitle1,
    required this.icon1,
    this.onTap,
    this.onTap1,
  });

  final UserProfileController controller;

  @override
  Widget build(BuildContext context) {
    return GradientBox(
        widthFactor: 1,
        heightFactor: 0.20,
        gradientColors: const [
          AppColors.primaryColor,
          AppColors.mainColor,
        ],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onTap,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    8.horizontal,
                    Text(
                      title,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.lightColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(AppAssets.arrowRight)
                  ],
                ),
              ),
              4.vertical,
              Text(
                subtitle,
                style: AppTextStyles.lightStyle.copyWith(
                  color: AppColors.lightColor,
                ),
              ),
              16.vertical,
              InkWell(
                onTap: onTap1,
                child: Row(
                  children: [
                    SvgPicture.asset(
                      icon1,
                      height: 22,
                      colorFilter: ColorFilter.mode(
                        AppColors.whiteColor,
                        BlendMode.srcIn,
                      ),
                    ),
                    8.horizontal,
                    Text(
                      title1,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.lightColor,
                        fontFamily: AppFonts.sandBold,
                      ),
                    ),
                    Spacer(),
                    SvgPicture.asset(AppAssets.arrowRight)
                  ],
                ),
              ),
              4.vertical,
              Text(
                subtitle1,
                style: AppTextStyles.lightStyle.copyWith(
                  color: AppColors.lightColor,
                ),
              ),
            ],
          ),
        ));
  }
}
