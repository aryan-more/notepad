import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notepad/provider/notes.dart';
import 'package:notepad/provider/theme.dart';
import 'package:notepad/utils/theme.dart';
import 'package:notepad/view/add_note/add.dart';
import 'package:notepad/view/home/mixin.dart';
import 'package:notepad/view/view_note/view.dart';
import 'package:notepad/widget/tile/note.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);
  static const routeName = "/home";

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    final notes = context.watch<Notes>();
    final theme = Theme.of(context).colorScheme.theme;
    return Scaffold(
      backgroundColor: theme.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.secondaryColor,
        title: const Text("Notepad"),
        actions: [
          selectMode
              ? IconButton(
                  onPressed: () => deleteSelected(setState: setState, context: context),
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    color: Colors.red,
                  ),
                )
              : IconButton(
                  onPressed: () async {
                    await Provider.of<ThemeProvider>(context, listen: false).set(darkMode: !theme.dark);
                  },
                  icon: Icon(
                    theme.dark ? Icons.nightlight_round : Icons.wb_sunny,
                  ),
                ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: StaggeredGrid.count(
          crossAxisCount: 2,
          crossAxisSpacing: 6,
          mainAxisSpacing: 6,
          children: notes.notes!.map(
            (note) {
              bool? isSelected = selectMode ? selected.contains(note) : null;

              return NoteTile(
                note: note,
                onTap: () => selectMode
                    ? isSelected!
                        ? unSelect(setState: setState, note: note)
                        : select(setState: setState, note: note)
                    : NoteView.navigate(context: context, note: note),
                onLongPress: () => selectMode
                    ? null
                    : setState(() {
                        select(setState: setState, note: note);
                      }),
                isSelected: isSelected,
              );
            },
          ).toList(),
        ),
      ),
      floatingActionButton: selectMode
          ? null
          : FloatingActionButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AddNoteView.routeName);
              },
              child: const Icon(Icons.add),
            ),
    );
  }
}
