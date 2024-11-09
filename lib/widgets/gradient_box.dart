import 'package:flutter/material.dart';

class GradientBox extends StatelessWidget {
  final Widget child;
  final List<Color> gradientColors;
  final double? widthFactor;
  final double? heightFactor;

  const GradientBox({
    super.key,
    required this.child,
    this.gradientColors = const [Colors.blue, Colors.purple],
    this.widthFactor,
    this.heightFactor,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: widthFactor != null ? screenWidth * widthFactor! : double.infinity,
      height:
          heightFactor != null ? screenHeight * heightFactor! : double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
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
