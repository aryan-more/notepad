import 'package:flutter/material.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/view/account/account.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme.appColorScheme;
    return Drawer(
      backgroundColor: theme.secondaryColor,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            color: theme.primaryColor,
            child: Text(
              "Notes",
              style: TextStyle(
                color: theme.textColor,
                fontSize: 22,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.account_circle_outlined),
            title: Text("Account"),
            onTap: () => Navigator.of(context).pushNamed(AccountView.routeName),
          )
        ],
      ),
    );
  }
}
