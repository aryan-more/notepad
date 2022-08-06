import 'dart:developer';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/notes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class NoteDataBase {
  static const tableName = "notes";
  static late Database database;

  static Future<void> init(BuildContext context) async {
    sqfliteFfiInit();
    var path = (await getApplicationDocumentsDirectory()).path;
    if ((Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
      database = await databaseFactoryFfi.openDatabase("$path/notes/note.db");
    } else {
      database = await openDatabase("$path/notes/note.db");
    }

    await database.execute("""
CREATE TABLE IF NOT EXISTS $tableName
(createdDate INTEGER PRIMARY KEY ,
lastUpdateDate  INTEGER NOT NULL,
title TEXT NOT NULL,
content TEXT NOT NULL)
""");

    var query = await database.query(tableName);
    log(query.toString());
    // ignore: use_build_context_synchronously
    Provider.of<Notes>(context, listen: false).set(List<Note>.from(query.map((e) => Note.fromMap(e)).toList()));
  }

  static void deleteDataBase() async {
    var path = (await getApplicationDocumentsDirectory()).path;

    if ((Platform.isWindows || Platform.isMacOS || Platform.isLinux)) {
      await databaseFactoryFfi.deleteDatabase("$path/notes/note.db");
    } else {
      await deleteDatabase("$path/notes/note.db");
    }
  }

  static Future<void> update({required Note note}) async {
    await database.update(
      tableName,
      note.toUpdateMap(),
      where: "createdDate = ?",
      whereArgs: [note.createdDate.millisecondsSinceEpoch],
    );
  }

  static Future<void> delete({required Note note}) async {
    await database.delete(
      tableName,
      where: "createdDate = ?",
      whereArgs: [note.createdDate.millisecondsSinceEpoch],
    );
  }

  static Future<void> insert({required Note note}) async {
    await database.insert(
      tableName,
      note.toMap(),
    );
  }
}
