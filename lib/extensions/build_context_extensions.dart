import 'package:flutter/material.dart';
import 'package:folly/l10n/app_localizations.dart';
import 'package:folly/widgets/app_snackbar_type.dart';

extension BuildContextExtensions on BuildContext {
  void showSnackBar({
    required String message,
    AppSnackbarType type = AppSnackbarType.positive,
  }) => ScaffoldMessenger.of(this).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: type.getBackgroundColor(this),
    ),
  );

  AppLocalizations get l10n => AppLocalizations.of(this);
  ThemeData get theme => Theme.of(this);
}
