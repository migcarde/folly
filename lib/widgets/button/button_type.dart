import 'package:flutter/material.dart';

enum ButtonType {
  normal,
  alternative,
  negative;

  ButtonStyle getOptionButtonStyle(ThemeData theme) {
    switch (this) {
      case ButtonType.normal:
        return ButtonStyle(
          textColor: theme.colorScheme.primaryContainer,
          backgroundColor: theme.colorScheme.onPrimaryContainer,
        );
      case ButtonType.negative:
        return ButtonStyle(
          textColor: theme.colorScheme.error,
          backgroundColor: theme.colorScheme.errorContainer,
        );
      case ButtonType.alternative:
        return ButtonStyle(
          textColor: theme.colorScheme.onPrimaryContainer,
          backgroundColor: theme.colorScheme.primaryContainer,
        );
    }
  }

  ButtonStyle getButtonStyle(ThemeData theme) {
    switch (this) {
      case ButtonType.normal:
        return ButtonStyle(
          textColor: theme.colorScheme.surface,
          backgroundColor: theme.primaryColor,
        );
      case ButtonType.alternative:
        return ButtonStyle(
          textColor: theme.primaryColor,
          backgroundColor: theme.colorScheme.surface,
        );
      case ButtonType.negative:
        return ButtonStyle(
          textColor: theme.colorScheme.errorContainer,
          backgroundColor: theme.colorScheme.error,
        );
    }
  }
}

class ButtonStyle {
  const ButtonStyle({required this.textColor, required this.backgroundColor});

  final Color textColor;
  final Color backgroundColor;
}
