import 'package:elevate_quote_generator/utils/constants.dart';
import 'package:flutter/material.dart';

class AddQuoteButton extends StatelessWidget {
  final VoidCallback onPressed;

  const AddQuoteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.0,
      height: 80.0,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10.0),
        ),
        onPressed: onPressed,
        child: Icon(
          Icons.add,
          size: 44.0,
          color: Theme.of(context).brightness == Brightness.dark
              ? AppConstants.addQuoteBtnIconColorDark
              : AppConstants.addQuoteBtnIconColorLight,
        ),
      ),
    );
  }
}