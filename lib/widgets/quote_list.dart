import 'package:elevate_quote_generator/models/quote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'favorite_quote_card.dart';

class QuoteList extends StatelessWidget {
  final List<Quote> quotes;
  final Locale locale;
  final Function(int) onDelete;
  final Function(Quote) onEdit;

  const QuoteList({
    super.key,
    required this.quotes,
    required this.locale,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return ListView.builder(
      itemCount: quotes.length,
      itemBuilder: (context, index) {
        final quote = quotes[index];
        return Dismissible(
          key: Key(quote.id.toString()),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
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
            onTap: () => onEdit(quote),
            child: QuoteCard(
              content: locale == const Locale('fr') ? quote.contentFr : quote.contentEn,
              author: quote.author,
              locale: locale,
            ),
          ),
        );
      },
    );
  }
}