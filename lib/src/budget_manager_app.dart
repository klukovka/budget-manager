import 'package:budget_manager/src/features/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';

class BudgetManagerApp extends StatelessWidget {
  const BudgetManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: SplashScreen.screenName,
      routes: routes,
      theme: theme,
    );
  }

  Map<String, WidgetBuilder> get routes => {
        SplashScreen.screenName: (context) => const SplashScreen(),
      };

  ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffe8eaf6),
        accentColor: const Color(0xffd3d5e0),
        splashColor: const Color(0xffd3d5e0),
        primaryIconTheme: const IconThemeData(color: Colors.black),
        fontFamily: 'Helvetica',
      );
}
