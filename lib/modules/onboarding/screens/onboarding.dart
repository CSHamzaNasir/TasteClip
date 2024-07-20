import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/core/widgets/onboarding_icon.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../../config/app_router.dart';
import '../../../core/widgets/boarding_skip_btn.dart';
import '../../../responsive/boarding.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    BoardingResponsiveProperties properties =
        BoardingResponsive.boardingImgSize(context);

    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(gradient: lightWhiteGradient),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height / 6),
                      const BoardingSkipBtn()
                    ],
                  ),
                  const Spacer(),
                  Center(
                    child: SvgPicture.asset(
                      welcome,
                      height: properties.height,
                      width: properties.width,
                    ),
                  ),
                  Text(
                    'Welcome to TasteClip',
                    style: TextStyle(
                        fontSize: properties.title,
                        color: textColor,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 18),
                  Center(
                    child: Text(
                      'Lets make your feedback matter. Get started in seconds and share your experiences effortlessly.',
                      style: TextStyle(
                          fontSize: properties.subTitle, color: mainColor),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const Spacer(),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Step 1 of 3',
                            style: TextStyle(
                                fontSize: properties.subTitle,
                                color: mainColor,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: () => AppRouter.push(AppRouter.onboarding1),
                          child: const OnboardingNextIcon(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
