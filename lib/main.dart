import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:tasteclip/core/route/app_router.dart';
import 'package:tasteclip/firebase_options.dart';
import 'package:tasteclip/modules/auth/splash/binding/initial_binding.dart'; 

import 'config/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return GetMaterialApp(
      initialBinding: InitialBinding(),
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      getPages: AppRouter.routes,
      initialRoute: AppRouter.splashScreen,
      // home: WelcomeScreen(),
    );
  }
}
