import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/provider/notes.dart';
import 'package:notepad/utils/theme.dart';
import 'package:notepad/view/add_note/mixin.dart';
import 'package:provider/provider.dart';

class AddNoteView extends StatefulWidget {
  const AddNoteView({Key? key}) : super(key: key);
  static const routeName = "/add_note";

  @override
  State<AddNoteView> createState() => _AddNoteViewState();
}

class _AddNoteViewState extends State<AddNoteView> with AddNoteMixin {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    final theme = Theme.of(context).colorScheme.theme;
    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        backgroundColor: theme.primaryColor,
        title: const Text("Add Note"),
        elevation: 0,
        actions: [
          if (title.text.isNotEmpty || content.text.isNotEmpty)
            IconButton(
              onPressed: () async {
                await notes.add(context: context, note: Note.createNew(title: title.text, content: content.text));
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              },
              icon: const Icon(Icons.save),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: TextField(
                controller: title,
                onChanged: (_) => setState(() {}),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                ),
              ),
            ),
            const Divider(),
            Flexible(
              child: TextField(
                controller: content,
                onChanged: (_) => setState(() {}),
                keyboardType: TextInputType.multiline,
                maxLines: 300,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
