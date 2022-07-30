import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool? darkMode;

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    darkMode = prefs.getBool("isDark");
  }

  Future<void> set({required bool darkMode}) async {
    this.darkMode = darkMode;
    notifyListeners();
    var prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isDark", darkMode);
  }

  ThemeMode getMode() {
    switch (darkMode) {
      case false:
        return ThemeMode.light;
      case true:
        return ThemeMode.dark;
      default:
        return ThemeMode.system;
    }
  }
}
