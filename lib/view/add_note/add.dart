import 'package:flutter/material.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/notes.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/add_note/mixin.dart';
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
    final theme = Theme.of(context).colorScheme.appColorScheme;
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
                final note = Note.createNew(title: title.text, content: content.text);
                final fireStore = Provider.of<FireBaseFirestore?>(context, listen: false);
                if (fireStore != null) {
                  fireStore.add(note: note);
                } else {
                  await Provider.of<Notes>(context, listen: false).add(context: context, note: note);
                }
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
                  focusedBorder: InputBorder.none,
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
                  focusedBorder: InputBorder.none,
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
