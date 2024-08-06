import 'package:flutter/material.dart';
import 'package:tasteclip/constant/app_text.dart';
import 'package:tasteclip/constant/app_button.dart';
import 'package:tasteclip/core/auth/screens/authentication.dart';

class RoleButton extends StatelessWidget {
  const RoleButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppButton(
          text: 'User',
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (ctx) => const Authentication()));
          },
          backgroundColor: secondaryColor,
          foregroundColor: lightColor,
        ),
        const SizedBox(height: 15),
        AppButton(
          text: 'Guest',
          onPressed: () {},
          backgroundColor: primaryColor,
          foregroundColor: lightColor,
        ),
        const SizedBox(height: 36),
        const Row(children: [
          Expanded(child: Divider(color: primaryColor)),
          Text(
            " or continue with ",
            style: TextStyle(fontSize: h5, color: primaryColor),
          ),
          Expanded(child: Divider(color: primaryColor)),
        ]),
        const SizedBox(height: 25),
        AppButton(
          text: 'Restaurant Manager',
          onPressed: () {},
          backgroundColor: lightColor,
          btnSideClr: true,
          foregroundColor: mainColor,
        ),
      ],
    );
  }
}
