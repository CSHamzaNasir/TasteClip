import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: AppRouter.key,
      onGenerateRoute: AppRouter.onGenerateRoute,
      initialRoute: AppRouter.splashScreen,
    );
  }
}
