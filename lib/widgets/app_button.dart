import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tasteclip/config/app_text_styles.dart';
import 'package:tasteclip/constant/app_colors.dart';

class AppButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool btnSideClr;
  final bool isLoading;
  final double? btnRadius;
  final bool isGradient;
  final Color? btnColor;

  const AppButton({
    super.key,
    required this.text,
    this.icon,
    required this.onPressed,
    this.btnSideClr = false,
    this.isLoading = false,
    this.btnRadius,
    this.isGradient = true,
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
        gradient: isGradient
            ? const LinearGradient(
                colors: [
                  AppColors.textColor,
                  AppColors.mainColor,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              )
            : null,
        color: !isGradient ? btnColor : null,
        borderRadius: BorderRadius.circular(btnRadius ?? 12),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.lightColor,
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(btnRadius ?? 12),
            side: BorderSide(
              color: btnSideClr ? AppColors.primaryColor : Colors.transparent,
              width: 1,
            ),
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
                  Text(text,
                      style: AppTextStyles.bodyStyle.copyWith(
                        color: AppColors.lightColor,
                      )),
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
      btnHeight = 50;
    } else {
      btnHeight = 60;
    }

    return ButtonResponsiveProperties(
      btnHeight: btnHeight,
    );
  }
}
