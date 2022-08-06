import 'package:flutter/material.dart';

void showSuccessSnackBar({
  required BuildContext context,
  required String text,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: Colors.green,
      content: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    ),
  );
}
