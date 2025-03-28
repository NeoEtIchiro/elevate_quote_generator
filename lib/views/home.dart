import 'package:elevate_quote_generator/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:elevate_quote_generator/widgets/quote_card.dart';
import 'package:elevate_quote_generator/widgets/action_row.dart';
import 'package:elevate_quote_generator/views/settings.dart';
import 'package:elevate_quote_generator/views/favorites.dart';
import 'package:elevate_quote_generator/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String quote = 'This is a quote.';
  String author = '- Author';

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  Future<void> generateQuote() async {
    final httpClient = HttpClient()
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;

    final request = await httpClient.getUrl(Uri.parse('https://api.quotable.io/random?maxLength=130'));
    final response = await request.close();

    if (response.statusCode == 200) {
      final responseBody = await response.transform(utf8.decoder).join();
      final data = json.decode(responseBody);
      setState(() {
        quote = data['content'];
        author = data['author'];
      });
    } else {
      throw Exception('Failed to load quote');
    }
  }

  void _dislikeAction() {
    setState(() {
      generateQuote();
    });
  }

  void _favoriteAction() {
    setState(() {
      _openFavorites();
    });
  }

  void _likeAction() {
    setState(() {
      generateQuote();
    });
  }

  void _openSettings() {
    // Navigate to the settings page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          isDarkMode: MainApp.of(context)?.isDarkMode ?? false,
          toggleDarkMode: MainApp.of(context)?.toggleDarkMode ?? (value) {},
          locale: MainApp.of(context)?.locale,
          setLocale: MainApp.of(context)?.setLocale ?? (locale) {},
        ),
      ),
    );
  }

  void _openFavorites() {
    // Navigate to the favorites page
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(
          isDarkMode: MainApp.of(context)?.isDarkMode ?? false,
          locale: MainApp.of(context)?.locale,
        ),
      ),
    );
  }

  void _onMenuItemSelected(String value) {
    // Handle menu item selection
    switch (value) {
      case 'a_propos':
      // Action for item 1
        break;
      case 'info':
      // Action for item 2
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSettingsPressed: _openSettings,
        onMenuItemSelected: _onMenuItemSelected,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: QuoteCard(quote: quote, author: author)),
            const SizedBox(height: 32.0),
            ActionRow(
              onDislike: _dislikeAction,
              onFavorite: _favoriteAction,
              onLike: _likeAction,
            ),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }
}