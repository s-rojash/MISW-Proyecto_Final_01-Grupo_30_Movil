import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:abcjobs_movil/Utils/utils.dart';

import 'Pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ABCJobs',
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: ThemeData(
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: HexColor("5793e0"),
          primary: HexColor("ffffff"),
          surface: HexColor("5793e0"),
          onPrimary: HexColor("5793e0"),
        ),
        useMaterial3: true,
          inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: Colors.white,
              labelStyle: TextStyle(
                color: HexColor("00639A"),
              )
          )
      ),
      home: LoginPage(title: 'ABCJobs'),
    );
  }
}
