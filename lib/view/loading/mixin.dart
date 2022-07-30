import 'package:flutter/cupertino.dart';
import 'package:notepad/database/notes.dart';
import 'package:notepad/view/home/home.dart';

mixin LoadingMixin {
  void load(BuildContext context) async {
    await NoteDataBase.init(context);
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacementNamed(HomeView.routeName);
  }
}
