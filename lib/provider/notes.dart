// ignore_for_file: body_might_complete_normally_nullable

import 'package:flutter/material.dart';
import 'package:notes/database/notes.dart';
import 'package:notes/models/note.dart';
import 'package:notes/widget/dialogues/loading_dialog.dart';

class Notes extends ChangeNotifier {
  late List<Note> _notes;

  List<Note> get notes => _notes;

  void set(List<Note> notes) {
    _notes = notes;
    notifyListeners();
  }

  Future<void> add({
    required BuildContext context,
    required Note note,
  }) async {
    _notes.add(note);
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
      await saveChanges(
        context: context,
        fun: () async {
          note.applyUpdate(
            title: title,
            content: content,
          );
          await NoteDataBase.update(note: note);
        },
      );
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
            notes.remove(note);
          }
        });
    notifyListeners();
  }
}
