import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:notepad/view/loading/loading.dart';
import 'package:notepad/view/not_found.dart';

Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case LoadingView.routeName:
      return LoadingView();
    default:
      return MaterialPageRoute(
        builder: (context) => ErrorViewNotFound(),
        settings: routeSettings,
      );
  }
}
