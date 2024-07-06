import 'package:flutter/material.dart';
import 'package:tasteclip/theme/style.dart';

class OnBoardingButtton extends StatelessWidget {
  const OnBoardingButtton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
        ),
        backgroundColor: mainColor,
        minimumSize: const Size(80, 30),
      ),
      child: Text('skip', style: AppTextStyles.style6),
    );
  }
}
