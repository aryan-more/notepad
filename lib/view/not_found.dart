import 'package:flutter/material.dart';

class ErrorViewNotFound extends StatelessWidget {
  const ErrorViewNotFound({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Something Went Wrong"),
      ),
    );
  }
}
