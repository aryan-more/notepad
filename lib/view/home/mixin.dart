import 'package:flutter/cupertino.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/widget/dialogues/delete.dart';

mixin HomeViewMixin {
  Set<Note> selected = {};
  bool selectMode = false;

  void select({required void Function(VoidCallback) setState, required Note note}) {
    setState(
      () {
        selected.add(note);
        selectMode = true;
      },
    );
  }

  void unSelect({required void Function(VoidCallback) setState, required Note note}) {
    setState(
      () {
        selected.remove(note);
        selectMode = selected.isNotEmpty;
      },
    );
  }

  void deleteSelected({required void Function(VoidCallback) setState, required BuildContext context}) {
    deleteDialog(context: context, notesToDelete: selected.toList()).then((deleted) {
      setState(
        () {
          selected.clear();
          selectMode = false;
        },
      );
    });
  }
}
