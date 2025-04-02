import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/models/quote.dart';

class QuotePopup extends StatefulWidget {
  final Function onQuoteAdded;
  final Quote? initialQuote;

  const QuotePopup({super.key, 
    required this.onQuoteAdded,
    this.initialQuote,
  });

  @override
  _QuotePopupState createState() => _QuotePopupState();
}

class _QuotePopupState extends State<QuotePopup> {
  late TextEditingController _contentController;
  late TextEditingController _authorController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.initialQuote?.contentEn ?? '');
    _authorController = TextEditingController(text: widget.initialQuote?.author ?? '');
  }

  void _addOrUpdateQuote() async {
    final content = _contentController.text;
    final author = _authorController.text;

    if (content.isNotEmpty && author.isNotEmpty) {
      final quote = Quote(
        id: widget.initialQuote?.id,
        contentEn: content,
        contentFr: content, // Assuming same content for both languages
        author: author,
      );
      widget.onQuoteAdded(quote);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(
        widget.initialQuote == null
            ? localizations!.addQuoteTitle
            : localizations!.editQuoteTitle,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _contentController,
            decoration: InputDecoration(labelText: localizations.quote),
          ),
          TextField(
            controller: _authorController,
            decoration: InputDecoration(labelText: localizations.author),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(localizations.cancel),
        ),
        ElevatedButton(
          onPressed: _addOrUpdateQuote,
          child: Text(localizations.saveQuote),
        ),
      ],
    );
  }
}