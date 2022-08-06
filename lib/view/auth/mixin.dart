// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/cupertino.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:notes/widget/dialogues/loading_dialog.dart';
import 'package:provider/provider.dart';

mixin SignInViewMixin {
  void userMode({
    required BuildContext context,
  }) async {
    await saveChanges(
      context: context,
      fun: () {},
    );
  }

  Future<void> skipSignIn({
    required BuildContext context,
  }) async {
    await saveChanges(
      context: context,
      fun: () async {
        await NoteDataBase.init(context);
      },
    );
  }

  Future<void> anonymousSignUp({
    required BuildContext context,
  }) async {
    await saveChanges(
      context: context,
      fun: () async {
        FireBaseService.signInAnonymuosly();
        Provider.of<UserPreferencesProvider>(context, listen: false).setUserMode(UserMode(UserMode.firebase));
      },
    );
  }
}
