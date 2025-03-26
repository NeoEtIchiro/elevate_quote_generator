import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback onSettingsPressed;
  final ValueChanged<String> onMenuItemSelected;

  const CustomAppBar({
    super.key,
    required this.onSettingsPressed,
    required this.onMenuItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        'Elevate',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
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