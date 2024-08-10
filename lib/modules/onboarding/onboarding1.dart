import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import 'package:tasteclip/utils/skip_btn.dart';
import '../../config/app_router.dart';
import '../../responsive/boarding.dart';

class Onboarding1 extends StatelessWidget {
  const Onboarding1({super.key});

  @override
  Widget build(BuildContext context) {
    BoardingResponsiveProperties properties =
        BoardingResponsive.boardingImgSize(context);
    return Scaffold(
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
                    const SkipBtn()
                  ],
                ),
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    mission,
                    height: properties.height,
                    width: properties.width,
                  ),
                ),
                Text('Our Mission',
                    style: TextStyle(
                        fontSize: properties.title,
                        color: textColor,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 18),
                Center(
                  child: Text(
                    'We are on a mission to empower your voice. Join us in shaping better dining experiences together.',
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
                      Text('Step 2 of 3',
                          style: TextStyle(
                              fontSize: properties.subTitle,
                              color: mainColor,
                              fontWeight: FontWeight.bold)),
                      const SizedBox(width: 20),
                      MaterialButton(
                        minWidth: 10,
                        color: secondaryColor,
                        shape: const CircleBorder(),
                        onPressed: () {
                          AppRouter.push(AppRouter.onboarding2);
                        },
                        child: const Icon(
                          Icons.arrow_forward,
                          color: lightColor,
                          size: 17,
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
