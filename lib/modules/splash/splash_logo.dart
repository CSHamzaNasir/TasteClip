import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_logo.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import 'package:tasteclip/responsive/splash.dart';
import '../../config/app_router.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    SplashResponsiveProperties properties =
        SplashResponsive.boardingImgSize(context);
    Future.delayed(const Duration(seconds: 3), () {
      AppRouter.push(AppRouter.splashText);
    });

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: lightWhiteGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const AppLogo(),
              const Spacer(),
              Text(
                'TasteClip',
                style: TextStyle(
                    fontSize: properties.title,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              Text('Version 1.0',
                  style: TextStyle(
                    fontSize: properties.subTitle,
                    color: primaryColor,
                  )),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
