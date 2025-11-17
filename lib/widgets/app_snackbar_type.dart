import 'package:flutter/material.dart';

enum AppSnackbarType {
  positive,
  negative;

  Color getBackgroundColor(BuildContext context) {
    final theme = Theme.of(context);

    switch (this) {
      case AppSnackbarType.positive:
        return theme.colorScheme.primary;
      case AppSnackbarType.negative:
        return theme.colorScheme.error;
    }
  }
}
