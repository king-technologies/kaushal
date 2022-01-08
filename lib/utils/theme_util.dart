import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'shared_pref_util.dart';

class ThemeUtils extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance?.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    SharedPref.setTheme(isOn ? 1 : 2);
    notifyListeners();
  }
}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: const AppBarTheme(
      color: Colors.black,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
    ),
    primaryColor: Colors.black,
    colorScheme: const ColorScheme(
        brightness: Brightness.dark,
        primary: Colors.black,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black,
        error: Colors.red,
        onError: Colors.redAccent,
        background: Colors.black,
        onBackground: Colors.white,
        surface: Colors.black,
        onSurface: Colors.white),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
      overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
    ),
    textTheme: const TextTheme(
      headline4: TextStyle(fontSize: 20, color: Colors.white),
      headline6: TextStyle(fontSize: 24, color: Colors.black),
      headline5: TextStyle(fontSize: 44, color: Colors.white),
      subtitle1: TextStyle(fontSize: 14, color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        elevation: MaterialStateProperty.all(1),
        shadowColor: MaterialStateProperty.all(Colors.white),

        // foregroundColor: MaterialStateProperty.all(Colors.black),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
      ),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.white),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
    ),
    primaryColor: Colors.white,
    colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: Colors.white,
        onPrimary: Colors.black,
        secondary: Colors.black,
        onSecondary: Colors.white,
        error: Colors.redAccent,
        onError: Colors.red,
        background: Colors.white,
        onBackground: Colors.black,
        surface: Colors.white,
        onSurface: Colors.black),
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.black),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
      overlayColor: MaterialStateProperty.all(Colors.black.withOpacity(0.1)),
    ),
    textTheme: const TextTheme(
      headline6: TextStyle(fontSize: 24, color: Colors.white),
      headline4: TextStyle(fontSize: 20, color: Colors.black),
      headline5: TextStyle(fontSize: 44, color: Colors.black),
      subtitle1: TextStyle(fontSize: 14, color: Colors.black),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0))),
          shadowColor: MaterialStateProperty.all(Colors.black),
          elevation: MaterialStateProperty.all(1),
          backgroundColor: MaterialStateProperty.all(Colors.black),
          padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 10, horizontal: 15))),
    ),
    primaryIconTheme: const IconThemeData(color: Colors.black),
  );
}
