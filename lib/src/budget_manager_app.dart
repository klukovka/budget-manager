import 'package:budget_manager/src/features/splash_screen/splash_screen.dart';
import 'package:budget_manager/src/features/transaction_screen/transaction_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BudgetManagerApp extends StatelessWidget {
  const BudgetManagerApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: TransactionScreen.screenName,
      routes: routes,
      theme: theme,
    );
  }

  Map<String, WidgetBuilder> get routes => {
        SplashScreen.screenName: (context) => const SplashScreen(),
        TransactionScreen.screenName: (context) => const TransactionScreen(),
      };

  ThemeData get theme => ThemeData(
        primaryColor: const Color(0xffd3d5e0),
        accentColor: const Color(0xffd3d5e0),
        splashColor: const Color(0xffbbbdc7),
        backgroundColor: const Color(0xffe8eaf6),
        scaffoldBackgroundColor: const Color(0xffe8eaf6),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(
                const Color(0xff2b2b2b)),
            side: MaterialStateProperty.all(const BorderSide()),
            minimumSize: MaterialStateProperty.all(const Size.fromHeight(50)),
            backgroundColor: MaterialStateProperty.all(
              const Color(0xffd3d5e0),
            ),
            textStyle: MaterialStateProperty.all(
              const TextStyle(
                  color: Color(0xff2b2b2b),
                  fontSize: 16),
            ),
            elevation: MaterialStateProperty.all(0),
          ),
        ),
        
        dividerTheme: const DividerThemeData(color: Colors.black, thickness: 2),
        focusColor: Colors.black,
        radioTheme:
            RadioThemeData(fillColor: MaterialStateColor.resolveWith((states) {
          if (states.any((element) => element == MaterialState.selected)) {
            return Colors.black;
          }
          return const Color(0xff909199);
        })),
        iconTheme: const IconThemeData(color: Colors.black, size: 35.0),
        fontFamily: 'Helvetica',
        textTheme: TextTheme(
          headline1: const TextStyle(
              color: Colors.black, fontSize: 30, fontFamily: 'HelveticaHeavy'),
          headline2: const TextStyle(color: Colors.black, fontSize: 24),
          headline3: const TextStyle(color: Colors.black, fontSize: 24),
          headline4: TextStyle(color: Colors.red[900], fontSize: 24),
          bodyText1: const TextStyle(
              color: Color(0xff2b2b2b), fontSize: 16),
          subtitle1: const TextStyle(
              color: Color(0xff909199), fontSize: 16),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xffd3d5e0), elevation: 5),
      );
}
