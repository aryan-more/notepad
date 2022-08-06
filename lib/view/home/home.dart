import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:notes/models/note.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/add_note/add.dart';
import 'package:notes/view/home/mixin.dart';
import 'package:notes/view/view_note/view.dart';
import 'package:notes/widget/home_drawer.dart';
import 'package:notes/widget/tile/note.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key, required this.notes}) : super(key: key);
  final List<Note> notes;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.appColorScheme;
    final userProvider = context.watch<UserPreferencesProvider>();
    return Scaffold(
      drawer: const HomeDrawer(),
      backgroundColor: theme.secondaryColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: theme.secondaryColor,
        title: const Text("Notes"),
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
                    await userProvider.setTheme(darkMode: !theme.dark);
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
          children: widget.notes.map(
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
