import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'firebase_options.dart';
import 'pages/auth_page.dart';
import 'services/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Hive.initFlutter();
  var box = await Hive.openBox('myThemeBox');
  bool isDarkMode = false;
  if (box.get('isDarkMode') != null) {
    isDarkMode = box.get('isDarkMode');
  } else {
    await box.put('isDarkMode', false);
  }

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    theme: CustomTheme.lightTheme,
    darkTheme: CustomTheme.darkTheme,
    themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
    home: const AuthPage(),
  ));
}
