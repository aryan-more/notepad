import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/auth_email/mixin.dart';

class SignInOrSignUpEmailView extends StatefulWidget {
  const SignInOrSignUpEmailView({Key? key, required this.signIn}) : super(key: key);
  final bool signIn;

  static Future<bool?> navigate({required bool signIn, required BuildContext context}) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (context) => SignInOrSignUpEmailView(
          signIn: signIn,
        ),
      ),
    );
  }

  @override
  State<SignInOrSignUpEmailView> createState() => _SignInOrSignUpEmailViewState();
}

class _SignInOrSignUpEmailViewState extends State<SignInOrSignUpEmailView> with SignInOrSignUpEmailMixin {
  @override
  void initState() {
    signIn = widget.signIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.appColorScheme;

    return Scaffold(
      backgroundColor: theme.primaryColor,
      appBar: AppBar(
        title: Text(
          signIn ? "Sign In" : "Sign Up",
        ),
        actions: [
          if (FirebaseAuth.instance.currentUser == null)
            TextButton(
              onPressed: () => setState(() {
                signIn = !signIn;
              }),
              child: Text(
                signIn ? "Sign Up?" : "Sign In?",
              ),
            )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              key: formkey,
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    focusNode: emailNode,
                    onFieldSubmitted: (_) => FocusScope.of(context).requestFocus(passwordNode),
                    controller: emailController,
                    validator: emailValidator,
                    decoration: const InputDecoration(
                      labelText: "Email",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    focusNode: passwordNode,
                    controller: passwordController,
                    validator: passwordValidator,
                    obscureText: obscurePassword,
                    onFieldSubmitted: (_) => signIn ? onSubmit(context) : FocusScope.of(context).requestFocus(confirmPasswordNode),
                    decoration: InputDecoration(
                      labelText: "Password",
                      suffixIcon: IconButton(
                        icon: Icon(
                          obscurePassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                        ),
                        onPressed: () => setState(
                          () {
                            obscurePassword = !obscurePassword;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  if (!signIn)
                    TextFormField(
                      focusNode: confirmPasswordNode,
                      controller: confirmPasswordController,
                      validator: confirmPasswordValidator,
                      obscureText: obscureConfirmPassword,
                      onFieldSubmitted: (_) => onSubmit(context),
                      decoration: InputDecoration(
                        labelText: "Confirm Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirmPassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye_rounded,
                          ),
                          onPressed: () => setState(
                            () {
                              obscureConfirmPassword = !obscureConfirmPassword;
                            },
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (signIn)
                  TextButton(
                    onPressed: () => forgotPassword(context: context),
                    child: const Text("Forgot Password?"),
                  ),
                ElevatedButton(
                  onPressed: () => onSubmit(context),
                  child: Text(
                    signIn ? "Sign In" : "Sign Up",
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
