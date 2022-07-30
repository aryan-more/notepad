// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:notepad/database/notes.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/widget/dialogues/loading_dialog.dart';

class Notes extends ChangeNotifier {
  List<Note>? _notes;

  List<Note>? get notes => _notes;

  void set(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }

  Future<void> add({
    required BuildContext context,
    required Note note,
  }) async {
    _notes?.add(note);
    await saveChanges(
        context: context,
        fun: () async {
          await NoteDataBase.insert(note: note);
        });
    notifyListeners();
  }

  Future<void> update({
    required BuildContext context,
    required Note note,
    required String title,
    required String content,
  }) async {
    if (note.title != title || note.content != content) {
      note.applyUpdate(
        title: title,
        content: content,
      );
      await saveChanges(
          context: context,
          fun: () async {
            await NoteDataBase.update(note: note);
          });
    }
    notifyListeners();
  }

  Future<void> deletes({
    required BuildContext context,
    required List<Note> notesToDelete,
  }) async {
    await saveChanges(
        context: context,
        fun: () async {
          for (var note in notesToDelete) {
            await NoteDataBase.delete(note: note);
            this.notes?.remove(note);
          }
        });
    notifyListeners();
  }
}
