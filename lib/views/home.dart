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
import 'dart:collection';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final Queue<Map<String, String>> _quotesQueue = Queue();
  final QuotesService _quotesService = QuotesService();
  final ValueNotifier<Locale> _localeNotifier = ValueNotifier<Locale>(const Locale('en'));

  @override
  void initState() {
    super.initState();
    _localeNotifier.value = MainApp.of(context)?.locale ?? const Locale('en');
    _loadInitialQuotes();
  }

  Future<void> _loadInitialQuotes() async {
    for (int i = 0; i < 5; i++) {
      await _loadNewQuote();
    }
    setState(() {});
  }

  Future<void> _loadNewQuote() async {
    final newQuote = await _quotesService.generateQuote();
    _quotesQueue.add({
      'content_en': newQuote['content_en']!,
      'content_fr': newQuote['content_fr']!,
      'author': newQuote['author']!,
    });
  }

  void _updateQuote() {
    if (_localeNotifier.value.languageCode == 'fr') {
      setState(() {});
    } else {
      setState(() {});
    }
  }

  void _dislikeAction() {
    _quotesQueue.removeFirst();
    _loadNewQuote();
    setState(() {});
  }

  void _favoriteAction() {
    _openFavorites();
  }

  void _likeAction() async {
    final currentQuote = _quotesQueue.removeFirst();
    await DatabaseHelper.instance.addQuote(currentQuote['content_fr']!, currentQuote['content_en']!, currentQuote['author']!);
    _loadNewQuote();
    setState(() {});
  }

  void _openSettings() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SettingsScreen(
          isDarkMode: MainApp.of(context)?.isDarkMode ?? false,
          toggleDarkMode: MainApp.of(context)?.toggleDarkMode ?? (value) {},
          locale: _localeNotifier.value,
          setLocale: (locale) {
            _localeNotifier.value = locale;
            _updateQuote();
          },
        ),
      ),
    );
  }

  void _openFavorites() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FavoritesScreen(
          isDarkMode: MainApp.of(context)?.isDarkMode ?? false,
          locale: _localeNotifier.value,
        ),
      ),
    );
  }

  void _onMenuItemSelected(String value) {
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
    final currentQuote = _quotesQueue.isNotEmpty ? _quotesQueue.first : {'content_en': '', 'content_fr': '', 'author': ''};
    final quote = _localeNotifier.value.languageCode == 'fr' ? currentQuote['content_fr']! : currentQuote['content_en']!;
    final author = currentQuote['author']!;

    return ValueListenableBuilder<Locale>(
      valueListenable: _localeNotifier,
      builder: (context, locale, child) {
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
      },
    );
  }
}