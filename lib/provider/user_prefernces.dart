import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferencesProvider extends ChangeNotifier {
  bool? darkMode;
  UserMode? userMode;
  late bool localToFirestoreUploadRequired;
  final _controller = StreamController<UserMode?>();

  Stream<UserMode?> get userModeStream => _controller.stream;

  void setUserMode(UserMode? newUserMode) async {
    if (userMode != null && userMode!.userMode == UserMode.local && newUserMode != null && newUserMode.userMode == UserMode.firebase) {
      setlocalToFirestoreUploadRequired(true);
    }
    userMode = newUserMode;
    _controller.sink.add(userMode);
    var prefs = await SharedPreferences.getInstance();
    if (newUserMode != null) {
      await prefs.setString("User Mode", newUserMode.userMode);
    } else {
      await prefs.remove("User Mode");
    }
  }

  void setlocalToFirestoreUploadRequired(bool uploadRequired) async {
    localToFirestoreUploadRequired = uploadRequired;
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool("localToFirestoreUplordRequired", localToFirestoreUploadRequired);
    if (!localToFirestoreUploadRequired) {
      NoteDataBase.deleteDataBase();
    }
  }

  Future<void> init() async {
    var prefs = await SharedPreferences.getInstance();
    var mode = prefs.getString("User Mode");
    localToFirestoreUploadRequired = prefs.getBool("localToFirestoreUplordRequired") ?? false;
    if (mode != null) {
      userMode = UserMode(mode);
      _controller.sink.add(userMode);
    }
    darkMode = prefs.getBool("isDark");
  }

  Future<void> setTheme({required bool darkMode}) async {
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
