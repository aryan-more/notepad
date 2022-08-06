import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/view/account/account.dart';
import 'package:notes/view/add_note/add.dart';
import 'package:notes/view/loading/loading.dart';
import 'package:notes/view/not_found.dart';
import 'package:notes/view/view_note/view.dart';
import 'package:notes/view/wrapper.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoadingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const LoadingView(),
        settings: routeSettings,
      );

    case AddNoteView.routeName:
      return MaterialPageRoute(
        builder: (context) => const AddNoteView(),
        settings: routeSettings,
      );

    case UserModeWrapper.routeName:
      return MaterialPageRoute(
        builder: (context) => const UserModeWrapper(),
        settings: routeSettings,
      );

    case AccountView.routeName:
      return MaterialPageRoute(
        builder: (context) => const AccountView(),
        settings: routeSettings,
      );
    case NoteView.routeName:
      Note note = routeSettings.arguments as Note;
      return MaterialPageRoute(
        builder: (context) => NoteView(
          note: note,
        ),
        settings: routeSettings,
      );
    default:
      return MaterialPageRoute(
        builder: (context) => const ErrorViewNotFound(),
        settings: routeSettings,
      );
  }
}
