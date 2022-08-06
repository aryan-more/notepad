import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';

mixin NoteViewMixin {
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  bool changed = false;

  void init(Note note) {
    titleController.text = note.title;
    contentController.text = note.content;
  }

  void onDispose() {
    titleController.dispose();
    contentController.dispose();
  }

  void onChange({required Note note, required void Function(VoidCallback) setState}) {
    if ((titleController.text != note.title || contentController.text != note.content) != changed) {
      setState(
        () {
          changed = !changed;
        },
      );
    }
  }
}
