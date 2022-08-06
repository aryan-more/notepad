import 'package:flutter/cupertino.dart';
import 'package:notes/view/auth_email/auth_email.dart';

mixin AccountViewMixin {
  void redirectToAuth(BuildContext context) {
    SignInOrSignUpEmailView.navigate(
      signIn: false,
      context: context,
    ).then((value) {
      if (value != null && value) {
        Navigator.of(context).pop();
      }
    });
  }
}
