import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/services/data.dart';
import 'favorite_quote_card.dart';

class QuoteList extends StatelessWidget {
  final List<Map<String, dynamic>> quotes;
  final Locale locale;
  final Function(int) onDelete;
  final Function(int, String, String) onEdit;

  const QuoteList({
    Key? key,
    required this.quotes,
    required this.locale,
    required this.onDelete,
    required this.onEdit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return Dismissible(
          key: Key(quote['id'].toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) async {
            await DatabaseHelper.instance.deleteQuote(quote['id']);
            onDelete(index);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(localizations!.quoteDeleted)),
            );
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: GestureDetector(
            onTap: () => onEdit(
              quote['id'],
              locale == const Locale('fr') ? (quote['content_fr'] ?? '') : (quote['content_en'] ?? ''),
              quote['author'] ?? '',
            ),
            child: QuoteCard(
              content: locale == const Locale('fr') ? (quote['content_fr'] ?? '') : (quote['content_en'] ?? ''),
              author: quote['author'] ?? '',
              locale: locale,
            ),
          ),
        );
      },
    );
  }
}