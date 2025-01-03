import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';
import 'pages/auth_page.dart';
import 'services/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.lightTheme,
    darkTheme: CustomTheme.darkTheme,
    themeMode: Get.isDarkMode ? ThemeMode.dark : ThemeMode.light,
    home: const AuthPage(),
  ));
}
