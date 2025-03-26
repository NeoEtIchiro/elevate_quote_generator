import 'package:flutter/material.dart';
import 'package:elevate_quote_generator/widgets/quote_card.dart';
import 'package:elevate_quote_generator/widgets/action_row.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Elevate',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
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