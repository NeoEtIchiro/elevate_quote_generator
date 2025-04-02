import 'package:elevate_quote_generator/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations!.aboutTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              localizations.appName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              localizations.version,
              style: AppConstants.txtBase,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.description,
              style: AppConstants.txtBase,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.developers,
              style: AppConstants.txtBase,
            ),
            const SizedBox(height: 16),
            Text(
              localizations.license,
              style: AppConstants.txtBase,
            ),
          ],
        ),
      ),
    );
  }
}