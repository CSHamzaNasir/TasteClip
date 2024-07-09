import 'package:flutter/material.dart';
import 'package:tasteclip/theme/appbar.dart';
import 'package:tasteclip/theme/text_style.dart';

class Signup extends StatelessWidget {
  const Signup({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CardAppBar(
            iconColor: secondaryColor,
            route: ('/role'),
            containerColor: lightColor,
          )
        ],
      ),
    );
  }
}
