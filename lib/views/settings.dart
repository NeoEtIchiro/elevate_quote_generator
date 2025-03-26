import 'package:elevate_quote_generator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = "en";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access Theme.of(context) here instead of initState
    final theme = Theme.of(context);
    _isDarkMode = theme.brightness == Brightness.dark;
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _changeLanguage(String? value) {
    setState(() {
      if (value != null && AppLocalizations.supportedLocales
          .any((locale) => locale.languageCode == value)) {
        _selectedLanguage = value;
        Locale newLocale = Locale(value);
        MainApp.of(context)?.setLocale(newLocale);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations!.settings)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(localizations.darkMode, style: const TextStyle(fontSize: 18)),
            Switch(
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            ),
            const SizedBox(height: 20),
            Text(localizations.language, style: const TextStyle(fontSize: 18)),
            Column(
              children: [
                RadioListTile<String>(
                  title: Text(localizations.french),
                  value: "fr",
                  groupValue: _selectedLanguage,
                  onChanged: _changeLanguage,
                ),
                RadioListTile<String>(
                  title: Text(localizations.english),
                  value: "en",
                  groupValue: _selectedLanguage,
                  onChanged: _changeLanguage,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}