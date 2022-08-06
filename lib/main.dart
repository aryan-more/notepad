import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes/provider/notes.dart';
import 'package:notes/provider/user_prefernces.dart';
import 'package:notes/services/firestore.dart';
import 'package:notes/utils/routes.dart';
import 'package:notes/utils/app_color_scheme.dart';
import 'package:notes/utils/support.dart';
import 'package:notes/view/loading/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final preferencesProvider = UserPreferencesProvider();
  await preferencesProvider.init();
  if (fireBaseSupport) {
    await Firebase.initializeApp();
  }
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => Notes(),
      ),
      ChangeNotifierProvider(
        create: (context) => preferencesProvider,
      ),
      StreamProvider.value(
        value: preferencesProvider.userModeStream,
        initialData: null,
      ),
      if (fireBaseSupport)
        StreamProvider.value(
          value: FireBaseService.onAuthStateChanged,
          initialData: null,
        ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(
        LightColorScheme(),
      ),
      darkTheme: getTheme(
        DarkAppColorScheme(),
      ),
      themeMode: context.watch<UserPreferencesProvider>().getMode(),
      title: "Notes",
      onGenerateRoute: onGenerateRoute,
      home: const LoadingView(),
    );
  }
}
