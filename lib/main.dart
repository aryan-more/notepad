import 'package:flutter/material.dart';
import 'package:notepad/utils/routes.dart';
import 'package:notepad/view/loading/loading.dart';

void main() {
  runApp(const MaterialApp(
    title: "Notes",
    onGenerateRoute: onGenerateRoute,
    initialRoute: LoadingView.routeName,
  ));
}
