import 'package:flutter/material.dart';

import '../constant/app_colors.dart';

ThemeData appTheme = ThemeData(
  colorScheme:
      ColorScheme.fromSwatch().copyWith(secondary: AppColors.primaryColor),
  scaffoldBackgroundColor: AppColors.transparent,
  // fontFamily: AppFonts.neutralRegular,
  useMaterial3: false,
);
