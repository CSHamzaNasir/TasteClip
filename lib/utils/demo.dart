import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';

class Demo extends StatelessWidget {
  const Demo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Center(
            child: Image.asset(logo),
          ),
          Center(
            child: SvgPicture.asset(
              logo1,
            ),
          )
        ],
      ),
    );
  }
}
