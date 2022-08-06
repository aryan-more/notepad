import 'package:flutter/material.dart';

extension CustomColorScheme on ColorScheme {
  AppColorScheme get appColorScheme => brightness == Brightness.light ? LightColorScheme() : DarkAppColorScheme();
}

abstract class AppColorScheme {
  Color primaryColor = const Color(0x0000000f);
  Color secondaryColor = const Color(0x0000000f);
  Color actionColor = const Color(0x0000000f);
  Color textColor = const Color(0x0000000f);
  bool dark = false;
}

class LightColorScheme implements AppColorScheme {
  @override
  Color primaryColor = Colors.white;

  @override
  Color secondaryColor = const Color.fromARGB(255, 247, 247, 247);

  @override
  Color actionColor = Colors.orange;

  @override
  Color textColor = Colors.black;

  @override
  bool dark = false;
}

class DarkAppColorScheme implements AppColorScheme {
  @override
  Color primaryColor = Colors.black;

  @override
  Color secondaryColor = Colors.grey[900]!;

  @override
  Color actionColor = Colors.amber;

  @override
  Color textColor = Colors.white;
  @override
  bool dark = true;
}

ThemeData getTheme(AppColorScheme theme) {
  ThemeData base;
  if (theme is LightColorScheme) {
    base = ThemeData.light();
  } else {
    base = ThemeData.dark();
  }
  return base.copyWith(
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: theme.actionColor,
      ),
      alignLabelWithHint: true,
      border: const OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: theme.actionColor,
          width: 2,
        ),
      ),
      suffixIconColor: theme.actionColor,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: theme.actionColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: theme.actionColor,
      selectionHandleColor: theme.actionColor,
      selectionColor: (theme.actionColor.withOpacity(0.6)),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(theme.actionColor),
        overlayColor: MaterialStateProperty.all(theme.secondaryColor.withOpacity(0.80)),
        textStyle: MaterialStateProperty.all(
          TextStyle(
            color: theme.actionColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: theme.actionColor,
        minimumSize: const Size(
          double.infinity,
          50,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        textStyle: TextStyle(
          color: theme.textColor,
          fontSize: 18,
        ),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: theme.primaryColor,
      titleTextStyle: TextStyle(
        color: theme.textColor,
        fontSize: 22,
      ),
      iconTheme: IconThemeData(
        color: theme.actionColor,
      ),
    ),
  );
}
