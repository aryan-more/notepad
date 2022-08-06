// ignore_for_file: use_build_context_synchronously

import 'package:flutter/cupertino.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:notes/view/wrapper.dart';
import 'package:provider/provider.dart';

mixin LoadingMixin {
  Future<void> load(BuildContext context) async {
    final pref = Provider.of<UserPreferencesProvider>(context, listen: false);

    if (pref.userMode != null) {
      if (pref.userMode!.userMode == UserMode.local || pref.localToFirestoreUploadRequired) {
        await NoteDataBase.init(context);
      }
    }

    await Future.delayed(const Duration(milliseconds: 100));
    Navigator.of(context).pushReplacementNamed(UserModeWrapper.routeName);
  }
}
