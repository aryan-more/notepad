import 'package:flutter/material.dart';
import 'package:notepad/models/note.dart';
import 'package:notepad/utils/theme.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({
    Key? key,
    required this.note,
    required this.onTap,
    required this.onLongPress,
    required this.isSelected,
  }) : super(key: key);
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final bool? isSelected;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.theme;
    return Padding(
      padding: EdgeInsets.all(isSelected != null ? 1.5 : 0),
      child: InkWell(
        splashColor: theme.actionColor,
        borderRadius: BorderRadius.circular(15),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
              decoration: BoxDecoration(
                color: theme.primaryColor.withAlpha(200),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (note.title.isNotEmpty)
                    Text(
                      note.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: theme.textColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                  if (note.content.isNotEmpty)
                    Text(
                      note.content,
                      style: const TextStyle(
                        fontSize: 16,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
            ),
            if (isSelected != null)
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: const EdgeInsets.only(right: 20, top: 20),
                  padding: EdgeInsets.all(isSelected! ? 3 : 0.5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: theme.actionColor,
                  ),
                  child: isSelected!
                      ? Icon(
                          Icons.check,
                          size: 17,
                          color: theme.primaryColor,
                        )
                      : Container(
                          height: 19.5,
                          width: 19.5,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.secondaryColor,
                          )),
                ),
              )
          ],
        ),
      ),
    );
  }
}
