import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'config/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: AppRouter.key,
        onGenerateRoute: AppRouter.onGenerateRoute,
        initialRoute: AppRouter.splashLogo,
        // home: const Demo(),
      ),
    );
  }
}
