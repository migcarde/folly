import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
  });

  final IconData icon;
  final String text;
  final VoidCallback onTap;

  static const _iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: _iconSize),
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.m),
            child: Text(text),
          ),
        ],
      ),
    );
  }
}
