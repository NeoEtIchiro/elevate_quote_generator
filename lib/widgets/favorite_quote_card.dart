import 'package:flutter/material.dart';

class QuoteCard extends StatelessWidget {
  final String content;
  final String author;
  final Locale locale;

  const QuoteCard({
    Key? key,
    required this.content,
    required this.author,
    required this.locale,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              content,
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              "- $author",
              style: const TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
            ),
          ],
        ),
      ),
    );
  }
}