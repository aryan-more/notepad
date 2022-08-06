// ignore_for_file: body_might_complete_normally_nullable, use_build_context_synchronously

import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/user_mode.dart';
import 'package:notes/widget/dialogues/loading_dialog.dart';
import 'package:notes/widget/snackbar/error.dart';
import 'package:notes/widget/snackbar/success.dart';
import 'package:provider/provider.dart';

mixin SignInOrSignUpEmailMixin {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  bool signIn = true;

  FocusNode emailNode = FocusNode();
  FocusNode passwordNode = FocusNode();
  FocusNode confirmPasswordNode = FocusNode();

  final formkey = GlobalKey<FormState>();

  Future<bool> connectionCheck(BuildContext context) async {
    if (await (InternetConnectionChecker.createInstance().connectionStatus) == InternetConnectionStatus.connected) {
      return true;
    }
    showErrorSnackBar(context: context, text: "No internet connection");

    return false;
  }

  void onDispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    emailNode.dispose();
    passwordNode.dispose();
    confirmPasswordNode.dispose();
  }

  String? emailValidator(String? email) {
    if (email != null && EmailValidator.validate(email)) {
      return null;
    }
    if (email!.isEmpty) {
      return "Please Enter Email";
    }
    return "Invalid Email ID";
  }

  String? passwordValidator(String? password) {
    if (password == null || password.length < 8) {
      return "Use 8 characters or more for your password";
    }
    return null;
  }

  String? confirmPasswordValidator(String? password) {
    if (password == null || password != passwordController.text) {
      return "Password doesn't match";
    }
    return null;
  }

  void onSubmit(BuildContext context) async {
    if (formkey.currentState!.validate() && await connectionCheck(context)) {
      bool result = await saveChanges(
          context: context,
          fun: () async {
            try {
              await FireBaseService.signInOrSignUpWithEmail(
                email: emailController.text,
                password: passwordController.text,
                signIn: signIn,
              );
              return true;
              // Navigator.of(context).pop();
            } on FirebaseException catch (e) {
              showErrorSnackBar(
                context: context,
                text: "Sign In Failed with error ${e.code}",
              );
            } catch (_) {
              showErrorSnackBar(
                context: context,
                text: "Sign In Failed",
              );
            }
            return false;
          }) as bool;
      if (result) {
        Provider.of<UserPreferencesProvider>(context, listen: false).setUserMode(UserMode(UserMode.firebase));
        Navigator.of(context).pop(true);
      }
    }
  }

  void forgotPassword({required BuildContext context}) async {
    String? error = emailValidator(emailController.text);
    if (error != null) {
      FocusScope.of(context).requestFocus(emailNode);
      return showErrorSnackBar(context: context, text: error);
    }
    if (await connectionCheck(context)) {
      saveChanges(
          context: context,
          fun: () async {
            try {
              await FirebaseAuth.instance.sendPasswordResetEmail(email: emailController.text);
              showSuccessSnackBar(context: context, text: "Password reset link sent at ${emailController.text}");
            } catch (e) {
              showErrorSnackBar(context: context, text: "Unable to send password reset link");
            }
          });
    }
  }
}
