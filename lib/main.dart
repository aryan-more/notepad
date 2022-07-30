import 'package:flutter/material.dart';
import 'package:notepad/provider/notes.dart';
import 'package:notepad/provider/theme.dart';
import 'package:notepad/utils/routes.dart';
import 'package:notepad/utils/theme.dart';
import 'package:notepad/view/loading/loading.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final themeProvider = ThemeProvider();
  await themeProvider.init();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(
        create: (context) => Notes(),
      ),
      ChangeNotifierProvider(
        create: (context) => themeProvider,
      ),
    ], child: const MyApp()),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: getTheme(
        LightAppTheme(),
      ),
      darkTheme: getTheme(
        DarkAppTheme(),
      ),
      themeMode: context.watch<ThemeProvider>().getMode(),
      title: "Notes",
      onGenerateRoute: onGenerateRoute,
      home: const LoadingView(),
    );
  }
}
