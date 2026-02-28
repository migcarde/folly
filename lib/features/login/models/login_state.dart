import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';

enum LoginStatus {
  connected,
  loading,
  disconnected;

  bool get isConnected => this == LoginStatus.connected;
  bool get isLoading => this == LoginStatus.loading;
}

enum LoginError {
  alreadyRegistered,
  invalidCredentials,
  invalidEmail,
  emailRequired,
  userBanned,
  passwordRequired,
  unknown,
  none;

  bool get isInvalidCredentials => this == LoginError.invalidCredentials;
  bool get isUnknown => this == LoginError.unknown;

  String getMessage(BuildContext context) {
    final l10n = context.l10n;
    switch (this) {
      case LoginError.alreadyRegistered:
        return l10n.user_already_registered_please_use_another_email;
      case LoginError.unknown:
        return l10n.sorry_we_have_problems_please_try_again_later;
      case LoginError.invalidCredentials:
      case LoginError.invalidEmail:
        return l10n.invalid_credentials_please_try_again;
      case LoginError.none:
        return '';
      case LoginError.userBanned:
        return l10n.user_banned;
      case LoginError.passwordRequired:
      case LoginError.emailRequired:
        return l10n.required_field;
    }
  }

  factory LoginError.fromAuthException({required AuthException exception}) {
    switch (exception) {
      case AuthException.emailAlreadyInUse:
        return LoginError.alreadyRegistered;
      case AuthException.userNotFound:
      case AuthException.invalidCredentials:
        return LoginError.invalidCredentials;
      case AuthException.userBanned:
        return LoginError.userBanned;
      case AuthException.invalidEmail:
        return LoginError.invalidEmail;
      default:
        return LoginError.unknown;
    }
  }
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.disconnected,
    this.errors = const [],
    this.info = '',
  });

  final LoginStatus status;
  final List<LoginError> errors;
  final String info;

  @override
  List<Object?> get props => [status, errors, info];

  LoginState copyWith({
    LoginStatus? status,
    List<LoginError>? errors,
    String? info,
  }) => LoginState(
    status: status ?? this.status,
    errors: errors ?? this.errors,
    info: info ?? this.info,
  );

  LoginState logout() =>
      const LoginState(status: LoginStatus.disconnected, errors: []);
}

extension LoginErrorsExtensions on List<LoginError> {
  bool get hasEmailErrors =>
      contains(LoginError.emailRequired) ||
      contains(LoginError.invalidEmail) ||
      contains(LoginError.invalidCredentials) ||
      contains(LoginError.userBanned);

  String getEmailErrorMessage(BuildContext context) {
    final l10n = context.l10n;

    if (contains(LoginError.emailRequired)) {
      return l10n.required_field;
    } else if (contains(LoginError.invalidEmail)) {
      return l10n.email_not_valid;
    } else if (contains(LoginError.invalidCredentials)) {
      return l10n.invalid_credentials_please_try_again;
    } else if (contains(LoginError.userBanned)) {
      return l10n.user_banned;
    } else {
      return '';
    }
  }
}
