import 'package:folly/l10n/app_localizations.dart';

enum ResetPasswordStatus {
  success,
  passwordsDoesNotMatch,
  weakPassword,
  unknownError,
  none;

  bool get isSuccess => this == ResetPasswordStatus.success;
  bool get isPasswordsDoesNotMatch =>
      this == ResetPasswordStatus.passwordsDoesNotMatch;
  bool get isWeakPassword => this == ResetPasswordStatus.weakPassword;
  bool get isUnknownError => this == ResetPasswordStatus.unknownError;

  String getText({required AppLocalizations l10n}) {
    switch (this) {
      case ResetPasswordStatus.success:
        return l10n.password_changed;
      case ResetPasswordStatus.passwordsDoesNotMatch:
        return l10n.password_does_not_match;
      case ResetPasswordStatus.weakPassword:
        return l10n.passwords_is_weak;
      case ResetPasswordStatus.unknownError:
        return l10n.sorry_we_have_problems_please_try_again_later;
      case ResetPasswordStatus.none:
        return '';
    }
  }
}
