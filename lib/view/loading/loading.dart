import 'package:flutter/material.dart';
import 'package:notepad/utils/theme.dart';
import 'package:notepad/view/loading/mixin.dart';

class LoadingView extends StatelessWidget with LoadingMixin {
  const LoadingView({Key? key}) : super(key: key);

  static const routeName = "/loading";

  @override
  Widget build(BuildContext context) {
    load(context);
    final theme = Theme.of(context).colorScheme.theme;

    return Scaffold(
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: theme.actionColor,
            ),
            const SizedBox(
              width: 10,
            ),
            const Text(
              "Loading",
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
