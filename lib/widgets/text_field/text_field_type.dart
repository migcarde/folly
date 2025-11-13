import 'package:flutter/material.dart';

enum TextFieldType {
  initial,
  alternative,
  none;

  bool get isNone => this == TextFieldType.none;

  TextFieldStyle getStyle(ThemeData theme) {
    switch (this) {
      case TextFieldType.initial:
        return TextFieldStyle(
          textColor: theme.textTheme.bodyLarge?.color ?? Colors.white,
          backgroundColor: Colors.white,
          borderColor: Colors.transparent,
        );
      case TextFieldType.alternative:
        return TextFieldStyle(
          textColor: theme.textTheme.bodyLarge?.color ?? Colors.white,
          backgroundColor: Colors.white,
          borderColor: theme.primaryColor,
        );
      case TextFieldType.none:
        return TextFieldStyle(
          textColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
        );
    }
  }
}

class TextFieldStyle {
  const TextFieldStyle({
    required this.textColor,
    required this.backgroundColor,
    required this.borderColor,
  });

  final Color textColor;
  final Color backgroundColor;
  final Color borderColor;
}
