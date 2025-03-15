import 'package:flutter/material.dart';
import 'package:tasteclip/core/constant/app_colors.dart';

class CustomBox extends StatelessWidget {
  final Widget? child;
  final double? containerHeight;
  final double? width;
  final EdgeInsetsGeometry? padding;
  final Color? bgColor;
  final VoidCallback? onTap;
  final double? radius;
  const CustomBox({
    super.key,
    this.padding,
    this.child,
    this.containerHeight,
    this.width,
    this.bgColor,
    this.onTap,
    this.radius,
    Color? color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: containerHeight,
        width: width,
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? 12),
            color: bgColor ?? AppColors.whiteColor),
        child: child,
      ),
    );
  }
}
