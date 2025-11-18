import 'package:flutter/material.dart';

class BottomDialogOption extends StatelessWidget {
  const BottomDialogOption({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  static const _iconSize = 42.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: _iconSize),
          Text(label),
        ],
      ),
    );
  }
}
