import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/utils/date_format.dart';
import 'package:notes/utils/app_color_scheme.dart';

void infoDialog({
  required BuildContext context,
  required Note note,
}) {
  final theme = Theme.of(context).colorScheme.appColorScheme;

  showDialog(
    context: context,
    builder: (context) => Align(
      alignment: Alignment.bottomCenter,
      child: Material(
        color: Colors.transparent,
        child: Container(
          margin: const EdgeInsets.all(8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
            color: theme.secondaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Note Details",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text("Created ${formatDate(note.createdDate)}"),
              const SizedBox(
                height: 15,
              ),
              Text("Last updated ${formatDate(note.lastUpdateDate)}"),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text("Done"),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
