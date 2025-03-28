import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/services/data.dart';

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
          return Card(
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
          );
        },
      ),
    );
  }
}