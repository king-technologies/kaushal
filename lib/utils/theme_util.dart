import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import '../values/colors.dart';
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
    scaffoldBackgroundColor: kPrimaryColor,
    appBarTheme: AppBarTheme(
      color: kPrimaryColor,
      centerTitle: true,
      titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    primaryColor: kPrimaryColor,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(Colors.white),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
      overlayColor: MaterialStateProperty.all(Colors.white.withOpacity(0.1)),
    ),
    textTheme: TextTheme(
      headline6: TextStyle(fontSize: 24, color: kPrimaryColor),
      headline4: const TextStyle(fontSize: 20, color: Colors.white),
      subtitle1: const TextStyle(fontSize: 14, color: Colors.white),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
          ),
        ),
        shadowColor: MaterialStateProperty.all(Colors.white),
        overlayColor: MaterialStateProperty.all(
          Colors.grey.shade800.withOpacity(0.3),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black),
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
    appBarTheme: AppBarTheme(
      color: Colors.white,
      centerTitle: true,
      titleTextStyle: TextStyle(
          color: kPrimaryColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5),
      elevation: 0,
      iconTheme: IconThemeData(color: kPrimaryColor),
    ),
    primaryColor: Colors.white,
    switchTheme: SwitchThemeData(
      thumbColor: MaterialStateProperty.all(kPrimaryColor),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackColor: MaterialStateProperty.all(kPrimaryColor.withOpacity(0.1)),
      overlayColor: MaterialStateProperty.all(kPrimaryColor.withOpacity(0.1)),
    ),
    textTheme: TextTheme(
      headline6: const TextStyle(fontSize: 24, color: Colors.white),
      headline4: TextStyle(fontSize: 20, color: kPrimaryColor),
      subtitle1: TextStyle(fontSize: 14, color: kPrimaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        ),
        shadowColor: MaterialStateProperty.all(kPrimaryColor),
        overlayColor: MaterialStateProperty.all(
          Colors.black.withOpacity(0.2),
        ),
        foregroundColor: MaterialStateProperty.all(Colors.black),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        ),
      ),
    ),
    primaryIconTheme: IconThemeData(color: kPrimaryColor),
  );
}
