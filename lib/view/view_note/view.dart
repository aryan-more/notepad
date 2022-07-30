import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/provider/notes.dart';
import 'package:notepad/utils/theme.dart';
import 'package:notepad/view/view_note/mixin.dart';
import 'package:notepad/widget/dialogues/delete.dart';
import 'package:notepad/widget/dialogues/info.dart';
import 'package:provider/provider.dart';

class NoteView extends StatefulWidget {
  const NoteView({
    Key? key,
    required this.note,
  }) : super(key: key);
  final Note note;
  static const routeName = "/view_note";
  @override
  State<NoteView> createState() => _NoteViewState();

  static void navigate({required BuildContext context, required Note note}) {
    Navigator.of(context).pushNamed(routeName, arguments: note);
  }
}

class _NoteViewState extends State<NoteView> with NoteViewMixin {
  @override
  void dispose() {
    super.dispose();
    onDispose();
  }

  @override
  void initState() {
    init(widget.note);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    final theme = Theme.of(context).colorScheme.theme;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(actions: [
        if (changed)
          IconButton(
            onPressed: () {
              notes
                  .update(
                    context: context,
                    note: widget.note,
                    title: titleController.text,
                    content: contentController.text,
                  )
                  .then(
                    (value) => Navigator.of(context).pop(),
                  );
            },
            icon: const Icon(
              Icons.save_outlined,
            ),
          ),
        IconButton(
          onPressed: () {
            deleteDialog(context: context, notesToDelete: [widget.note]).then((deleted) {
              if (deleted) {
                Navigator.of(context).pop();
              }
            });
          },
          icon: const Icon(
            Icons.delete_outline,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () => infoDialog(
            context: context,
            note: widget.note,
          ),
          icon: const Icon(
            Icons.info_outline,
          ),
        ),
      ], title: null),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Flexible(
              child: TextField(
                controller: titleController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: theme.textColor,
                ),
                onChanged: (x) => onChange(
                  note: widget.note,
                  setState: setState,
                ),
                maxLines: 2,
              ),
            ),
            const Divider(),
            Flexible(
              child: TextField(
                controller: contentController,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  color: theme.textColor,
                  fontSize: 18,
                ),
                onChanged: (x) => onChange(
                  note: widget.note,
                  setState: setState,
                ),
                maxLines: 300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
