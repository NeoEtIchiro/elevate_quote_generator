import 'package:flutter/material.dart';

class QuoteCard extends StatefulWidget {
  final String quote;
  final String author;

  const QuoteCard({
    super.key,
    required this.quote,
    required this.author,
  });

  @override
  _QuoteCardState createState() => _QuoteCardState();
}

class _QuoteCardState extends State<QuoteCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                widget.quote,
                style: const TextStyle(fontSize: 24.0),
              ),
              const SizedBox(height: 8.0),
              Text(
                widget.author,
                style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}