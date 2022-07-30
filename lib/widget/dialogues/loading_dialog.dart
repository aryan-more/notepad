import 'dart:async';

import 'package:flutter/material.dart';
import 'package:notepad/utils/theme.dart';

Future<void> saveChanges({required BuildContext context, required FutureOr<Object?> Function() fun}) async {
  final theme = Theme.of(context).colorScheme.theme;

  showDialog(
    context: context,
    builder: (context) => Dialog(
      backgroundColor: theme.secondaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(
              color: theme.actionColor,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              "Saving Changes",
              style: TextStyle(
                color: theme.actionColor,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    ),
    barrierDismissible: false,
  );

  var result = await fun();
  // ignore: use_build_context_synchronously
  Navigator.of(context).pop(result);
}
