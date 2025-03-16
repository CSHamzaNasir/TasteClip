import 'package:flutter/material.dart';


extension OnInt on int {
  SizedBox get vertical => SizedBox(height: toDouble());
  SizedBox get horizontal => SizedBox(width: toDouble());
}

extension CustomOpacity on Color {
  Color withCustomOpacity(double opacity) {
    return withAlpha((opacity * 255).round());
  }
}
