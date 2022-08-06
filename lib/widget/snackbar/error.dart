import 'package:flutter/material.dart';

void showErrorSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.red,
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
