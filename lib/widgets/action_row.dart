import 'package:flutter/material.dart';

class ActionRow extends StatelessWidget {
  final VoidCallback onDislike;
  final VoidCallback onFavorite;
  final VoidCallback onLike;

  const ActionRow({
    super.key,
    required this.onDislike,
    required this.onFavorite,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
            ),
            onPressed: onDislike,
            child: const Icon(Icons.close, size: 36.0, color: Colors.red),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
            ),
            onPressed: onFavorite,
            child: const Icon(Icons.star, size: 36.0, color: Colors.yellow),
          ),
        ),
        Expanded(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(24.0),
            ),
            onPressed: onLike,
            child: const Icon(Icons.favorite, size: 36.0, color: Colors.green),
          ),
        ),
      ],
    );
  }
}