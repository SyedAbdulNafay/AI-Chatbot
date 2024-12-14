import 'package:flutter/material.dart';

class CustomTheme {
  //light theme
  static final lightTheme = ThemeData(
    fontFamily: "MainFont",
    colorScheme: ColorScheme.light(
      outline: lightThemeNeutral1.withOpacity(0.28),
      primary: const Color(0xFF612A74),
      secondary: const Color(0xFFE8A089),
      tertiary: const Color(0xFF776F69),
      surface: Colors.white,
      inversePrimary: Colors.black,
    ),
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith((states) => const Color(0xFFE8A089)),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
  );

  static final darkTheme = ThemeData(
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFDF9ECD),
      secondary: const Color(0xFFFFC47F),
      tertiary: const Color(0xFF7A808C),
      outline: darkThemeNeutral1.withOpacity(0.32),
      surface: Colors.black,
      inversePrimary: Colors.white,
    ),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.black,
    fontFamily: "MainFont",
    useMaterial3: true,
    switchTheme: SwitchThemeData(
      thumbColor:
          WidgetStateProperty.resolveWith((states) => const Color(0xFFDF9ECD)),
    ),
    iconTheme: const IconThemeData(color: Color(0xFFDF9ECD)),
  );

  static Color lightThemeNeutral1 = const Color(0xFF7A808C),
      darkThemeNeutral1 = const Color(0xFF7A808C);
}
