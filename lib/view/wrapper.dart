// ignore_for_file: body_might_complete_normally_nullable

import 'package:notes/models/note.dart';
import 'package:notes/provider/notes.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/utils/support.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:notes/view/auth/auth.dart';
import 'package:notes/view/home/home.dart';
import 'package:notes/view/not_found.dart';
import 'package:notes/widget/dialogues/loading_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class FireBaseWrapper extends StatelessWidget {
  const FireBaseWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final fireStore = context.watch<FireBaseFirestore?>();
    final theme = Theme.of(context).colorScheme.appColorScheme;
    final user = Provider.of<UserPreferencesProvider>(context);

    if (fireStore == null) {
      return const AuthView();
    }
    return StreamBuilder(
      stream: fireStore.notes,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Something Went Wrong"));
        }
        if (snapshot.connectionState == ConnectionState.waiting || snapshot.data == null) {
          return Center(
            child: CircularProgressIndicator(
              color: theme.actionColor,
            ),
          );
        }

        if (user.localToFirestoreUploadRequired) {
          fireStore.addMultiple(notes: Provider.of<Notes>(context, listen: false).notes);
          user.setlocalToFirestoreUploadRequired(false);
        }

        return HomeView(
          notes: (snapshot.data as List<Note>),
        );
      },
    );
  }
}

class LocalWrapper extends StatelessWidget {
  const LocalWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    return HomeView(notes: notes.notes);
  }
}

class UserModeWrapper extends StatelessWidget {
  const UserModeWrapper({Key? key}) : super(key: key);

  static const routeName = "/root";

  @override
  Widget build(BuildContext context) {
    final userMode = context.watch<UserMode?>();

    if (userMode == null) {
      return const AuthView();
    }
    if (localSupport && userMode.userMode == UserMode.local) {
      return const LocalWrapper();
    }
    if (fireBaseSupport && userMode.userMode == UserMode.firebase) {
      return const FireBaseWrapper();
    }
    return const ErrorViewNotFound();
  }
}
