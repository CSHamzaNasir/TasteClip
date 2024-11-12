import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart'; // Import Material package for Colors.
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/constant/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool isLight;
  final bool isDark;
  final bool isDefault;

  const AppBackground({
    super.key,
    required this.child,
    this.isLight = false,
    this.isDark = false,
    this.isDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    String? backgroundImage;

    if (isLight) {
      backgroundImage = AppAssets.lightBg;
    } else if (isDark) {
      backgroundImage = AppAssets.darkBg;
    }

    return DecoratedBox(
      position: DecorationPosition.background,
      decoration: BoxDecoration(
        image: backgroundImage != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(backgroundImage),
              )
            : null,
        gradient: isDefault
            ? const LinearGradient(
                colors: [
                  AppColors.lightColor,
                  AppColors.whiteColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
      ),
      child: child,
    );
  }
}
