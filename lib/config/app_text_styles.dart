import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_colors.dart';
import 'package:tasteclip/constant/app_fonts.dart';

class AppTextStyles {
  static const TextStyle lightStyle = TextStyle(
    fontSize: 12,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.sandRegular,
  );

  static const TextStyle bodyStyle = TextStyle(
    fontSize: 16,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.sandRegular,
  );

  static const TextStyle boldBodyStyle = TextStyle(
    fontSize: 18,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.sandBold,
  );

  static const TextStyle headingStyle = TextStyle(
    fontSize: 36,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.sandSemiBold,
  );

  static const TextStyle headingStyle1 = TextStyle(
    fontSize: 22,
    color: AppColors.primaryColor,
    fontFamily: AppFonts.sandSemiBold,
  );
}
