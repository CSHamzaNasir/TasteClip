import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double? widthFactor;
  final double? heightFactor;
  final double? boxRadius;
  final double? padding;

  const GradientBox({
    super.key,
    required this.child,
    this.gradientColors = const [Colors.blue, Colors.purple],
    this.widthFactor,
    this.heightFactor,
    this.boxRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      padding: EdgeInsets.all(padding ?? 0),
      width: widthFactor != null ? screenWidth * widthFactor! : double.infinity,
      height:
          heightFactor != null ? screenHeight * heightFactor! : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(boxRadius ?? 12),
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: child,
    );
  }
}
