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
          minimumSize: const Size.fromHeight(55),
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
