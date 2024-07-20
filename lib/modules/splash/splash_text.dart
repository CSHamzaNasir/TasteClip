import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import '../../config/app_router.dart';
import '../../constant/app_text.dart';

class SplashText extends StatelessWidget {
  const SplashText({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      AppRouter.push(AppRouter.onboarding);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: lightWhiteGradient),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Spacer(),
            Center(
              child: Text(
                'Taste Clip',
                style: TextStyle(
                    fontSize: h1,
                    color: textColor,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Spacer(),
            Text(
              'Version 1.0',
              style: TextStyle(fontSize: h5, color: primaryColor),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
