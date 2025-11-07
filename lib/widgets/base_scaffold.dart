import 'package:flutter/material.dart';
import 'package:folly/widgets/base_screen.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({super.key, this.title, required this.child});

  final String? title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: title != null && title?.isNotEmpty == true
          ? AppBar(
              iconTheme: theme.iconTheme.copyWith(
                color: theme.colorScheme.primary,
              ),
              title: Text(
                title!,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
            )
          : null,
      body: SafeArea(child: BaseScreen(child: child)),
    );
  }
}
