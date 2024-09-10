import 'package:flutter/material.dart';
import 'package:tasteclip/widgets/app_background.dart';

class UserAuthScreen extends StatelessWidget {
  const UserAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const AppBackground(
      isDark: true,
      child: Scaffold(),
    );
  }
}
