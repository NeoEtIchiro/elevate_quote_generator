import 'package:elevate_quote_generator/models/quote.dart';
import 'package:elevate_quote_generator/providers/quote_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/widgets/quote_popup.dart';
import 'package:elevate_quote_generator/widgets/quote_list.dart';
import 'package:elevate_quote_generator/widgets/add_quote_button.dart';

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
  final QuoteProvider _quoteProvider = QuoteProvider();

  @override
  void initState() {
    super.initState();
    _fetchQuotes();
  }

  Future<void> _fetchQuotes() async {
    await _quoteProvider.fetchQuotes();
    setState(() {});
  }

  void _deleteQuote(int index) {
    final quote = _quoteProvider.quotes[index];
    _quoteProvider.deleteQuote(quote.id!);
  }

  void _editQuote(Quote quote) {
    _openAddQuotePopup(quote);
  }

  void _openAddQuotePopup(Quote? quote) {
    showDialog(
      context: context,
      builder: (context) => QuotePopup(
        onQuoteAdded: (updatedQuote) async {
          if (updatedQuote.id == null) {
            await _quoteProvider.addQuote(updatedQuote);
          } else {
            await _quoteProvider.updateQuote(updatedQuote);
          }
          _fetchQuotes();
        },
        initialQuote: quote,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    final locale = widget.locale ?? const Locale('en');

    return Scaffold(
      appBar: AppBar(title: Text(localizations!.favorites)),
      body: _quoteProvider.quotes.isEmpty
          ? Center(child: Text(localizations.noFavorites))
          : QuoteList(
              quotes: _quoteProvider.quotes,
              locale: locale,
              onDelete: _deleteQuote,
              onEdit: _editQuote,
            ),
      floatingActionButton: AddQuoteButton(
        onPressed: () => _openAddQuotePopup(null),
      ),
    );
  }
}