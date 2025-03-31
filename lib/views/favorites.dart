import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/services/data.dart';
import 'package:elevate_quote_generator/widgets/quote_popup.dart';

class FavoritesScreen extends StatefulWidget {
  final bool isDarkMode;
  final Locale? locale;

  const FavoritesScreen({
    super.key,
    required this.isDarkMode,
    required this.locale,
  });

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _quotes = [];

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    final quotes = await DatabaseHelper.instance.getAllQuotes();
    setState(() {
      _quotes = quotes;
    });
  }

  void _openAddQuotePopup({int? id, String? content, String? author}) {
    showDialog(
      context: context,
      builder: (context) => QuotePopup(
        onQuoteAdded: _fetchQuotes,
        initialContent: content,
        initialAuthor: author,
        quoteId: id,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(localizations!.favorites)),
      body: _quotes.isEmpty
          ? Center(child: Text(localizations.noFavorites))
          : ListView.builder(
        itemCount: _quotes.length,
        itemBuilder: (context, index) {
          final quote = _quotes[index];
          return GestureDetector(
            onTap: () => _openAddQuotePopup(
              id: quote['id'],
              content: quote['content'],
              author: quote['author'],
            ),
            child: Card(
              margin: const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0),
              child: Padding(
                padding: const EdgeInsets.only(top: 16.0, bottom: 16.0, left: 8.0, right: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      quote['content'],
                      style: const TextStyle(fontSize: 18.0),
                    ),
                    const SizedBox(height: 8.0),
                    Text(
                      "- ${quote['author']}",
                      style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: SizedBox(
        width: 80.0, // Custom size for the button
        height: 80.0, // Custom size for the button
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(10.0),// Set the background color
          ),
          onPressed: () => _openAddQuotePopup(),
          child: const Icon(
            Icons.add,
            size: 44.0, // Increase the icon size
            color: Colors.black, // Set the icon color to white
          ),
        ),
      ),
    );
  }
}