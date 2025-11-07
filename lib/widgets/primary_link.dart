import 'package:flutter/material.dart';

class PrimaryLink extends StatelessWidget {
  const PrimaryLink({
    super.key,
    required this.text,
    required this.onTap,
  });

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }
}
