import 'package:elevate_quote_generator/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/utils/theme.dart'; //

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  static _MainAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainAppState>();

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  Locale? _locale;
  get locale => _locale;
  bool _isDarkMode = false;
  get isDarkMode => _isDarkMode;


  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elevate Quote Generator',
      theme: AppThemes.lightTheme, // Utilisation du thème clair
      darkTheme: AppThemes.darkTheme, // Utilisation du thème sombre
      themeMode: _isDarkMode ? ThemeMode.dark : ThemeMode.light,
      locale: _locale ?? const Locale('en'),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: const MainScreen(),
    );
  }
}