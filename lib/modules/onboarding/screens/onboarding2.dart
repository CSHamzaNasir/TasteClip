import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../../config/app_router.dart';
import '../../../responsive/boarding.dart';

class Onboarding2 extends StatelessWidget {
  const Onboarding2({super.key});

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
                const Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [],
                ),
                const Spacer(),
                Center(
                  child: SvgPicture.asset(
                    vision,
                    height: properties.height,
                    width: properties.width,
                  ),
                ),
                Text('Our Vision',
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
                ElevatedButton(
                  onPressed: () {
                    AppRouter.push(AppRouter.role);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    backgroundColor: mainColor,
                    minimumSize:
                        (Size(properties.btnWidth, properties.btnHeight)),
                  ),
                  child: Text('Get Started',
                      style: TextStyle(
                          fontSize: properties.btnText,
                          color: lightColor,
                          fontWeight: FontWeight.normal)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
