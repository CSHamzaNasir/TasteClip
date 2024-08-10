import 'package:flutter/material.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/constant/app_text.dart';

class SkipBtn extends StatelessWidget {
  const SkipBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        AppRouter.push(AppRouter.role);
      },
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        backgroundColor: mainColor,
        minimumSize: const Size(80, 30),
      ),
      child:
          const Text('skip', style: TextStyle(fontSize: h6, color: lightColor)),
    );
  }
}
