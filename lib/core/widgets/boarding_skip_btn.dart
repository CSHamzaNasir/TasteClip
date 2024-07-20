import 'package:flutter/material.dart';
import '../../config/app_router.dart';
import '../../constant/app_text.dart';

class BoardingSkipBtn extends StatelessWidget {
  const BoardingSkipBtn({
    super.key,
  });

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
