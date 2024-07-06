import 'package:flutter/material.dart';
import 'package:tasteclip/theme/style.dart';

class Role extends StatelessWidget {
  const Role({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Text('Welcome to Taste Clip', style: AppTextStyles.style4),
          )
        ],
      ),
    );
  }
}
