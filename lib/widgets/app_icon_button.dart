import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';

class AppIconButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isLoading;
  final double? btnRadius;
  final Color? btnColor;

  const AppIconButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.isLoading = false,
    this.btnRadius,
    this.btnColor,
  });

  @override
  Widget build(BuildContext context) {
    ButtonResponsiveProperties properties =
        ButtonResponsive.btnResponsive(context);

    final screenWidth = MediaQuery.of(context).size.width;
    final bool showIcon = screenWidth > 300;

    return Container(
      decoration: BoxDecoration(
        color: btnColor,
        borderRadius: BorderRadius.circular(btnRadius ?? 12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.lightColor,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius ?? 12),
          ),
          minimumSize: Size.fromHeight(properties.btnHeight),
        ),
        onPressed: isLoading ? null : onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: isLoading
              ? [
                  const SpinKitThreeBounce(
                    color: AppColors.lightColor,
                    size: 20.0,
                  ),
                ]
              : [
                  if (icon != null && showIcon)
                    Icon(
                      icon,
                      size: 16,
                    ),
                  if (icon != null && showIcon) const SizedBox(width: 8),
                  Text(
                    text,
                    style: AppTextStyles.boldBodyStyle,
                  ),
                ],
        ),
      ),
    );
  }
}

class ButtonResponsiveProperties {
  final double btnHeight;

  ButtonResponsiveProperties({
    required this.btnHeight,
  });
}

class ButtonResponsive {
  static ButtonResponsiveProperties btnResponsive(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double btnHeight;

    if (screenWidth < 300 || screenHeight < 400) {
      btnHeight = 35;
    } else if (screenWidth < 350 || screenHeight < 500) {
      btnHeight = 40;
    } else {
      btnHeight = 50;
    }

    return ButtonResponsiveProperties(
      btnHeight: btnHeight,
    );
  }
}
