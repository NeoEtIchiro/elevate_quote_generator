import 'package:flutter/material.dart';

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
    required this.style
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: Theme.of(context).brightness == Brightness.dark
              ? Colors.white
              : Colors.black,
        ).merge(style
        ),
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
              const PopupMenuItem<String>(
                value: 'a_propos',
                child: Text('A propos'),
              ),
              const PopupMenuItem<String>(
                value: 'info',
                child: Text('Info'),
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