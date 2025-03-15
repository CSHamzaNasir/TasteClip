import 'package:flutter/material.dart';

import '../core/constant/app_colors.dart';

ThemeData appTheme = ThemeData(
  colorScheme: ColorScheme.fromSwatch().copyWith(
    primary: AppColors.textColor,
    secondary: AppColors.primaryColor,
  ),

  scaffoldBackgroundColor: AppColors.transparent,
  // fontFamily: AppFonts.neutralRegular,
  useMaterial3: false,
);
