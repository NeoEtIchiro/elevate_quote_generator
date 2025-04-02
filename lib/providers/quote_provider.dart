import 'package:flutter/material.dart';
import 'package:elevate_quote_generator/models/quote.dart';
import 'package:elevate_quote_generator/services/data.dart';

class QuoteProvider extends ChangeNotifier {
  List<Quote> _quotes = [];

  List<Quote> get quotes => _quotes;

  Future<void> fetchQuotes() async {
    final data = await DatabaseHelper.instance.getAllQuotes();
    _quotes = data.map((map) => Quote.fromMap(map)).toList();
    notifyListeners();
  }

  Future<void> addQuote(Quote quote) async {
    await DatabaseHelper.instance.addQuote(
      quote.contentFr,
      quote.contentEn,
      quote.author,
    );
    await fetchQuotes();
  }

  Future<void> updateQuote(Quote quote) async {
    if (quote.id != null) {
      await DatabaseHelper.instance.updateQuote(
        quote.id!,
        quote.contentFr,
        quote.contentEn,
        quote.author,
      );
      await fetchQuotes();
    }
  }

  Future<void> deleteQuote(int id) async {
    await DatabaseHelper.instance.deleteQuote(id);
    await fetchQuotes();
  }
}