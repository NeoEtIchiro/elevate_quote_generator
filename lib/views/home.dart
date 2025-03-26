import 'package:flutter/material.dart';
import 'package:elevate_quote_generator/widgets/quote_card.dart';
import 'package:elevate_quote_generator/widgets/action_row.dart';
import 'package:elevate_quote_generator/views/settings.dart';
import 'package:elevate_quote_generator/widgets/custom_app_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String quote = 'This is a quote.';
  String author = '- Author';

  void _dislikeAction() {
    setState(() {
      quote = 'Quote disliked';
      author = '';
    });
  }

  void _favoriteAction() {
    setState(() {
      quote = 'Favorite page';
      author = '- Star';
    });
  }

  void _likeAction() {
    setState(() {
      quote = 'Like quote';
      author = '- Favorite';
    });
  }

  void _openSettings() {
    // Navigate to the settings page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
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