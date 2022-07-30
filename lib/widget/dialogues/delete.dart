import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/provider/notes.dart';
import 'package:notepad/utils/theme.dart';
import 'package:provider/provider.dart';

Future<bool> deleteDialog({
  required BuildContext context,
  required List<Note> notesToDelete,
}) async {
  final theme = Theme.of(context).colorScheme.theme;

  assert(notesToDelete.isNotEmpty);
  return await showDialog<bool>(
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Delete ${notesToDelete.length > 1 ? "${notesToDelete.length} notes" : "note"} permanently?",
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text("Cancel"),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Flexible(
                        child: ElevatedButton(
                          onPressed: () async {
                            await Provider.of<Notes>(context, listen: false).deletes(context: context, notesToDelete: notesToDelete);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop(true);
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          child: const Text("Delete"),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ) ??
      false;
}
