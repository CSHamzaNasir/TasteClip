import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';

class AppTextStyles {
  static const TextStyle thinStyle = TextStyle(
    fontSize: 14,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.popinsLight,
  );
  static const TextStyle semiBoldStyle = TextStyle(
    fontSize: 24,
    color: AppColors.textColor,
    fontFamily: AppFonts.popinsSemiBold,
  );
  static const TextStyle mediumStyle = TextStyle(
    fontSize: 26,
    color: AppColors.textColor,
    fontFamily: AppFonts.popinsBold,
  );
  static const TextStyle boldStyle = TextStyle(
    fontSize: 34,
    color: AppColors.textColor,
    fontFamily: AppFonts.popinsBold,
  );
  static const TextStyle buttonStyle = TextStyle(
    fontSize: 20,
    color: AppColors.lightColor,
    fontFamily: AppFonts.popinsRegular,
  );
  static const TextStyle buttonStyle1 = TextStyle(
    fontSize: 16,
    color: AppColors.lightColor,
    fontFamily: AppFonts.popinsMedium,
  );
}
