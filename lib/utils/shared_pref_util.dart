import 'package:shared_preferences/shared_preferences.dart';

import '../values/strings.dart';

class SharedPref {
  static Future setTheme(int value) async {
    final preferences = await SharedPreferences.getInstance();
    preferences.setInt(themeSP, value);
  }

  static Future<int> getTheme() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getInt(themeSP) ?? 0;
  }

  static Future clearSharedPref() async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.clear();
  }
}
