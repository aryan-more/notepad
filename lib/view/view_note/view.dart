import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/notes.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/view_note/mixin.dart';
import 'package:notes/widget/dialogues/delete.dart';
import 'package:notes/widget/dialogues/info.dart';
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
    final theme = Theme.of(context).colorScheme.appColorScheme;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(actions: [
        if (changed)
          IconButton(
            onPressed: () {
              final fireStore = Provider.of<FireBaseFirestore?>(context, listen: false);

              if (fireStore != null) {
                fireStore.update(
                  context: context,
                  note: widget.note,
                  title: titleController.text,
                  content: contentController.text,
                );
                Navigator.of(context).pop();
              } else {
                Provider.of<Notes>(context, listen: false)
                    .update(
                      context: context,
                      note: widget.note,
                      title: titleController.text,
                      content: contentController.text,
                    )
                    .then(
                      (value) => Navigator.of(context).pop(),
                    );
              }
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
                  focusedBorder: InputBorder.none,
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
                  focusedBorder: InputBorder.none,
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
