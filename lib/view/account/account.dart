// ignore_for_file: body_might_complete_normally_nullable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/account/mixin.dart';
import 'package:notes/widget/dialogues/loading_dialog.dart';

class AccountView extends StatelessWidget with AccountViewMixin {
  const AccountView({Key? key}) : super(key: key);
  static const routeName = "/account";

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.appColorScheme;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: const Text(
          "Account",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FirebaseAuth.instance.currentUser != null
            ? Column(
                children: [
                  if (FirebaseAuth.instance.currentUser!.isAnonymous)
                    ListTile(
                      title: const Text("Anonymous account"),
                      subtitle: const Text("Sign Up to avoid losing notes"),
                      trailing: TextButton(child: const Text("Sign Up"), onPressed: () => redirectToAuth(context)),
                    )
                  else
                    ListTile(
                      title: const Text("Account"),
                      subtitle: Text(FirebaseAuth.instance.currentUser?.email ?? ""),
                    ),
                  ListTile(
                    title: const Text("Sign Out"),
                    trailing: TextButton(
                      onPressed: () async {
                        saveChanges(
                          context: context,
                          fun: () async {
                            await FireBaseService.signOut();
                            // ignore: use_build_context_synchronously
                            Navigator.of(context).pop();
                          },
                        );
                      },
                      child: const Text("Sign Out"),
                    ),
                  ),
                ],
              )
            : Column(
                children: [
                  ListTile(
                    title: const Text("Local account"),
                    subtitle: const Text("Sign Up to avoid losing notes"),
                    trailing: TextButton(child: const Text("Sign Up"), onPressed: () => redirectToAuth(context)),
                  )
                ],
              ),
      ),
    );
  }
}
