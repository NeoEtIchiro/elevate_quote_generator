import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSettingsPressed;
  final ValueChanged<String> onMenuItemSelected;
  final String title;
  final TextStyle style;

  const CustomAppBar({
    super.key,
    required this.onSettingsPressed,
    required this.onMenuItemSelected,
    required this.title,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context);
    return AppBar(
      title: Text(
        title,
        style: style,
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.settings),
          onPressed: onSettingsPressed,
        ),
        PopupMenuButton<String>(
          onSelected: onMenuItemSelected,
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem<String>(
                value: 'a_propos',
                child: Text(localizations!.aboutTitle),
              ),
              PopupMenuItem<String>(
                value: 'info',
                child: Text(localizations.info),
              ),
            ];
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}