import 'package:flutter/material.dart';
import 'package:folly/widgets/base_screen.dart';

class BaseScaffold extends StatelessWidget {
  const BaseScaffold({
    super.key,
    this.title,
    required this.child,
    this.canGoBack = false,
    this.bottomNavigationBar,
  });

  final String? title;
  final Widget child;
  final bool canGoBack;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final showTitle = title != null && title?.isNotEmpty == true;

    return Scaffold(
      appBar: canGoBack || showTitle
          ? AppBar(
              iconTheme: theme.iconTheme.copyWith(
                color: theme.colorScheme.primary,
              ),
              title: showTitle
                  ? Text(
                      title!,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    )
                  : null,
            )
          : null,
      bottomNavigationBar: bottomNavigationBar,
      body: SafeArea(child: BaseScreen(child: child)),
    );
  }
}
