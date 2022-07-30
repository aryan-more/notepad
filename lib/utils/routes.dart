import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/view/add_note/add.dart';
import 'package:notepad/view/home/home.dart';
import 'package:notepad/view/loading/loading.dart';
import 'package:notepad/view/not_found.dart';
import 'package:notepad/view/view_note/view.dart';

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

    case HomeView.routeName:
      return MaterialPageRoute(
        builder: (context) => const HomeView(),
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
