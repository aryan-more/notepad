import 'package:flutter/material.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/utils/support.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:notes/view/auth/mixin.dart';
import 'package:notes/view/auth_email/auth_email.dart';
import 'package:provider/provider.dart';

class AuthView extends StatefulWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> with SignInViewMixin {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.appColorScheme;
    final user = Provider.of<UserPreferencesProvider>(context);

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: const Text(
          "Welcom to notes",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (fireBaseSupport)
              Column(
                children: [
                  ElevatedButton(
                    onPressed: () async {
                      anonymousSignUp(context: context);
                    },
                    child: const Text(
                      "Sign in anonymously",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => SignInOrSignUpEmailView.navigate(signIn: true, context: context),
                    child: const Text(
                      "Sign in with email",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => SignInOrSignUpEmailView.navigate(signIn: false, context: context),
                    child: const Text(
                      "Sign up with email",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            if (localSupport)
              ElevatedButton(
                onPressed: () async {
                  await skipSignIn(context: context);
                  user.setUserMode(UserMode(UserMode.local));
                },
                child: const Text(
                  "Skip Sign In",
                ),
              ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }
}
