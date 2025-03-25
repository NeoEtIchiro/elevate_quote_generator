import 'package:flutter/material.dart';

class QuoteCard extends StatefulWidget {
  const QuoteCard({super.key});

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
            children: const <Widget>[
              Text(
                'This is a quote.',
                style: TextStyle(fontSize: 24.0),
              ),
              SizedBox(height: 8.0),
              Text(
                '- Author',
                style: TextStyle(fontSize: 16.0, fontStyle: FontStyle.italic),
              ),
            ],
          ),
        ),
      ),
    );
  }
}