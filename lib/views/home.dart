import 'package:elevate_quote_generator/main.dart';
import 'package:elevate_quote_generator/views/about.dart';
import 'package:elevate_quote_generator/views/info.dart';
import 'package:flutter/material.dart';
import 'package:elevate_quote_generator/widgets/quote_card.dart';
import 'package:elevate_quote_generator/widgets/action_row.dart';
import 'package:elevate_quote_generator/views/settings.dart';
import 'package:elevate_quote_generator/views/favorites.dart';
import 'package:elevate_quote_generator/widgets/custom_app_bar.dart';
import 'package:elevate_quote_generator/services/data.dart';
import 'package:elevate_quote_generator/services/apis/quotes.dart';


class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String quote = 'This is a quote.';
  String author = '- Author';
  final QuotesService _quotesService = QuotesService();

  @override
  void initState() {
    super.initState();
    generateQuote();
  }

  Future<void> generateQuote() async {
    final newQuote = await _quotesService.generateQuote();
    setState(() {
      quote = newQuote['content']!;
      author = newQuote['author']!;
    });
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

  void _likeAction() async {
    await DatabaseHelper.instance.addQuote(quote, author);
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const AboutScreen(),
          ),
        );
        break;
      case 'info':
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InfoScreen(),
          ),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onSettingsPressed: _openSettings,
        onMenuItemSelected: _onMenuItemSelected,
        title: 'Elevate',
        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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