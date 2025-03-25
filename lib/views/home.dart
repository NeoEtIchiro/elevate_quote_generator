import 'package:flutter/material.dart';
import 'package:elevate_quote_generator/widgets/quote_card.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Elevate',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: const Center(
        child: QuoteCard(),
      ),
    );
  }
}