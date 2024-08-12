import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:svg_flutter/svg.dart';
import 'package:tasteclip/config/app_router.dart';
import 'package:tasteclip/constant/app_button.dart';
import 'package:tasteclip/constant/app_feild.dart';
import 'package:tasteclip/constant/app_gradient.dart';
import 'package:tasteclip/constant/app_text.dart';
import 'package:tasteclip/constant/assets_path.dart';
import 'package:tasteclip/utils/loader.dart';

class PhoneAuth extends ConsumerStatefulWidget {
  const PhoneAuth({super.key});

  @override
  ConsumerState<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends ConsumerState<PhoneAuth> {
  final phoneAuthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(gradient: primaryWhiteGradient),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Verify Your Phone Number',
                    style: TextStyle(
                        fontSize: h2, fontWeight: bold, color: secondaryColor)),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Hero(
                  tag: 'textlogo',
                  child: SvgPicture.asset(
                    appLogo1,
                    height: 58,
                    width: 58,
                  ),
                ),
                const SizedBox(height: 15),
                RichText(
                    text: const TextSpan(
                        text: 'Taste',
                        style: TextStyle(
                            fontSize: h3,
                            color: secondaryColor,
                            fontWeight: bold),
                        children: <TextSpan>[
                      TextSpan(
                        text: 'Clip',
                        style: TextStyle(
                            fontSize: h3,
                            color: mainColor,
                            fontWeight: semibold),
                      )
                    ])),
                const SizedBox(height: 36),
                const AppFeild(
                  prefixIcon: Icons.person,
                  iconSize: 14,
                  iconColor: mainColor,
                  hintText: 'Username',
                ),
                const SizedBox(height: 15),
                AppFeild(
                  prefixIcon: Icons.phone,
                  iconSize: 14,
                  iconColor: mainColor,
                  controller: phoneAuthController,
                  hintText: 'Phone no',
                ),
                const SizedBox(height: 30),
                AppButton(
                    foregroundColor: lightColor,
                    backgroundColor: textColor,
                    text: 'Verify',
                    onPressed: () async {
                      String phoneNumber = phoneAuthController.text.trim();
                      if (phoneNumber.isEmpty || !phoneNumber.startsWith('+')) {
                        log('Phone number is invalid or not in E.164 format');
                        return;
                      }

                      await FirebaseAuth.instance.verifyPhoneNumber(
                        verificationCompleted:
                            (PhoneAuthCredential credential) {},
                        verificationFailed: (FirebaseAuthException ex) {
                          log('Phone number verification failed: ${ex.message}');
                        },
                        codeSent: (verificationId, int? resendToken) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  OtpScreen(verificationId: verificationId),
                            ),
                          );
                        },
                        codeAutoRetrievalTimeout: (verificationId) {},
                        phoneNumber: phoneNumber,
                      );
                    }),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Row(children: [
                  Expanded(child: Divider(color: primaryColor)),
                  Text(
                    " Or Continue with ",
                    style: TextStyle(
                        fontSize: h5,
                        color: mainColor,
                        fontWeight: FontWeight.w500),
                  ),
                  Expanded(child: Divider(color: primaryColor)),
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                Hero(
                  tag: 'googlePHhonebtn',
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          btnSideClr: true,
                          icon: FontAwesomeIcons.google,
                          text: 'Google',
                          foregroundColor: textColor,
                          backgroundColor: lightColor,
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                      Expanded(
                        child: AppButton(
                          icon: Icons.mail,
                          text: 'Email',
                          foregroundColor: lightColor,
                          backgroundColor: primaryColor,
                          onPressed: () {
                            AppRouter.push(AppRouter.signup);
                          },
                        ),
                      ),
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

class OtpScreen extends StatefulWidget {
  final String? verificationId;
  const OtpScreen({super.key, this.verificationId});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppFeild(
              controller: otpController,
              inputType: TextInputType.number,
              hintText: 'Enter OTP',
            ),
            AppButton(
                text: 'Send',
                onPressed: () async {
                  try {
                    if (widget.verificationId == null) {
                      log('Verification ID is null');
                      return;
                    }

                    PhoneAuthCredential credential =
                        PhoneAuthProvider.credential(
                            verificationId: widget.verificationId!,
                            smsCode: otpController.text.trim());

                    await FirebaseAuth.instance
                        .signInWithCredential(credential);

                    Navigator.push(
                      AppRouter.key.currentContext!,
                      MaterialPageRoute(
                        builder: (BuildContext context) => const FirstScreen(),
                      ),
                    );
                  } catch (e) {
                    log('Error during OTP verification: $e');
                  }
                })
          ],
        ),
      ),
    );
  }
}
