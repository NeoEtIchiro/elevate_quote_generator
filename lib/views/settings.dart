import 'package:elevate_quote_generator/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final void Function(bool) toggleDarkMode;
  final Locale? locale;
  final void Function(Locale) setLocale;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.toggleDarkMode,
    required this.locale,
    required this.setLocale,
  });

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;
  late String _selectedLanguage;

  @override
  void initState() {
    super.initState();
    _isDarkMode = widget.isDarkMode;
    _selectedLanguage = widget.locale?.languageCode ?? 'en';
  }

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
    widget.toggleDarkMode(value); // Update global state
  }

  void _changeLanguage(String? value) {
    if (value != null) {
      setState(() {
        _selectedLanguage = value;
      });
      widget.setLocale(Locale(value)); // Update global state
    }
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