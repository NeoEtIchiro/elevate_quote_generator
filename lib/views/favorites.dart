import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/services/data.dart';
import 'package:elevate_quote_generator/widgets/quote_popup.dart';
import 'package:elevate_quote_generator/widgets/quote_list.dart';
import 'package:elevate_quote_generator/widgets/add_quote_button.dart';

class FavoritesScreen extends StatefulWidget {
  final bool isDarkMode;
  final Locale? locale;

  const FavoritesScreen({
    Key? key,
    required this.isDarkMode,
    required this.locale,
  }) : super(key: key);

  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Map<String, dynamic>> _quotes = [];

  void _openAddQuotePopup({int? id, String? content, String? author}) {
    showDialog(
      context: context,
      builder: (context) =>
          QuotePopup(
            onQuoteAdded: _fetchQuotes,
            initialContent: content,
            initialAuthor: author,
            quoteId: id,
          ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    final quotes = await DatabaseHelper.instance.getAllQuotes();
    setState(() {
      _quotes = List.from(quotes);
    });
  }

  void _deleteQuote(int index) {
    setState(() {
      _quotes.removeAt(index);
    });
  }

  void _editQuote(int id, String content, String author) {
    _openAddQuotePopup(id: id, content: content, author: author);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final locale = widget.locale ??
        const Locale('en'); // Provide a default locale

    return Scaffold(
      appBar: AppBar(title: Text(localizations!.favorites)),
      body: _quotes.isEmpty
          ? Center(child: Text(localizations.noFavorites))
          : QuoteList(
        quotes: _quotes,
        locale: locale,
        onDelete: _deleteQuote,
        onEdit: _editQuote,
      ),
      floatingActionButton: AddQuoteButton(
        onPressed: _openAddQuotePopup,
      ),
    );
  }
}