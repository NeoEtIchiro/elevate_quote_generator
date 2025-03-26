import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false;
  String _selectedLanguage = "fr";

  void _toggleDarkMode(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void _changeLanguage(String? value) {
    setState(() {
      if (value != null) {
        _selectedLanguage = value;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Paramètres")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            const Text("Mode sombre", style: TextStyle(fontSize: 18)),
            Switch(
              value: _isDarkMode,
              onChanged: _toggleDarkMode,
            ),
            const SizedBox(height: 20),
            const Text("Langue", style: TextStyle(fontSize: 18)),
            Column(
              children: [
              RadioListTile<String>(
                title: const Text("Français"),
                value: "fr",
                groupValue: _selectedLanguage,
                onChanged: _changeLanguage,
              ),
              RadioListTile<String>(
                title: const Text("Anglais"),
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