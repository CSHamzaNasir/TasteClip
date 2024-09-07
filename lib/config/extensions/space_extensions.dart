import 'package:flutter/material.dart';

//SPACE EXTENSION
extension OnInt on int {
  SizedBox get vertical => SizedBox(height: toDouble());
  SizedBox get horizontal => SizedBox(width: toDouble());
}
