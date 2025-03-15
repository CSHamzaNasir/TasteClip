import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_assets.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  final bool isLight;
  final bool isDefault;

  const AppBackground({
    super.key,
    required this.child,
    this.isLight = false,
    this.isDefault = true,
  });

  @override
  Widget build(BuildContext context) {
    String? backgroundImage;

    if (isLight) {
      backgroundImage = AppAssets.lightBg;
    } else {
      backgroundImage = null;
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
            ? LinearGradient(
                colors: isLight
                    ? [
                        AppColors.lightColor,
                        AppColors.whiteColor,
                      ]
                    : [
                        AppColors.mainColor,
                        AppColors.primaryColor,
                      ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              )
            : null,
        color: !isDefault ? Colors.white : null,
      ),
      child: child,
    );
  }
}
