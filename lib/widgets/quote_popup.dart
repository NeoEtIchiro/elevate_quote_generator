import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:elevate_quote_generator/services/data.dart';

class QuotePopup extends StatefulWidget {
  final Function onQuoteAdded;
  final String? initialContent;
  final String? initialAuthor;
  final int? quoteId;

  const QuotePopup({
    required this.onQuoteAdded,
    this.initialContent,
    this.initialAuthor,
    this.quoteId,
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
    _contentController = TextEditingController(text: widget.initialContent);
    _authorController = TextEditingController(text: widget.initialAuthor);
  }

  void _addOrUpdateQuote() async {
    final content = _contentController.text;
    final author = _authorController.text;

    if (content.isNotEmpty && author.isNotEmpty) {
      if (widget.quoteId == null) {
        await DatabaseHelper.instance.addQuote(content, content, author);
      } else {
        await DatabaseHelper.instance.updateQuote(widget.quoteId!, content, content, author);
      }
      widget.onQuoteAdded(); // Notify the parent widget to refresh the list
      Navigator.pop(context);
    }
  }

  void _discardChanges() {
    _contentController.clear();
    _authorController.clear();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(
        widget.quoteId == null
            ? localizations!.addQuoteTitle
            : localizations!.editQuoteTitle,
        style: TextStyle(
          fontSize: 24.0, // Increase the font size
          fontWeight: FontWeight.bold,
        ),
      ),
      content: SingleChildScrollView(
        child: Column(
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
      ),
      actions: [
        ElevatedButton(
          onPressed: _discardChanges,
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