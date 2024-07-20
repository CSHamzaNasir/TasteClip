import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';
import '../../config/app_router.dart';
import '../../responsive/auth_btn.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({super.key});

  @override
  Widget build(BuildContext context) {
    final sizes = ResponsiveSize.getButtonSizes(context);

    return Column(
      children: [
        ElevatedButton(
          onPressed: () {
            AppRouter.push(AppRouter.login);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: secondaryColor,
            minimumSize: Size(
                sizes['loginSignupBtnWidth']!, sizes['loginSignupBtnHeight']!),
          ),
          child: const Text('Login',
              style: TextStyle(fontSize: h5, color: lightColor)),
        ),
        SizedBox(height: MediaQuery.of(context).size.height * 0.02),
        ElevatedButton(
          onPressed: () {
            AppRouter.push(AppRouter.signup);
          },
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            backgroundColor: primaryColor,
            minimumSize: Size(
                sizes['loginSignupBtnWidth']!, sizes['loginSignupBtnHeight']!),
          ),
          child: const Text('Sign Up',
              style: TextStyle(fontSize: h5, color: lightColor)),
        ),
        SizedBox(height: sizes['screenSpacing']!),
        const Row(children: [
          Expanded(child: Divider(color: primaryColor)),
          Text(
            " or continue with ",
            style: TextStyle(fontSize: h5, color: primaryColor),
          ),
          Expanded(child: Divider(color: primaryColor)),
        ]),
        SizedBox(height: sizes['screenSpacing']!),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                // AppRouter.push(AppRouter. );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: primaryColor),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: lightColor,
                minimumSize: Size(sizes['googlePhoneBtnWidth']!,
                    sizes['googlePhoneBtnHeight']!),
              ),
              child: const Text('Google',
                  style: TextStyle(fontSize: h5, color: textColor)),
            ),
            ElevatedButton(
              onPressed: () {
                // AppRouter.push(AppRouter. );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                backgroundColor: primaryColor,
                minimumSize: Size(sizes['googlePhoneBtnWidth']!,
                    sizes['googlePhoneBtnHeight']!),
              ),
              child: const Text('Phone',
                  style: TextStyle(fontSize: h5, color: lightColor)),
            ),
          ],
        ),
      ],
    );
  }
}
