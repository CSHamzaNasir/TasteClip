// gradient_styles.dart
import 'package:flutter/material.dart';
import 'package:tasteclip/theme/text_style.dart';

const lightWhiteGradient = LinearGradient(
  colors: [lightColor, whiteColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
const primaryWhiteGradient = LinearGradient(
  colors: [primaryColor, whiteColor],
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
);
