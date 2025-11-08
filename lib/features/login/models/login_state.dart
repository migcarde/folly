import 'package:domain/login/models/firebase_auth_errors.dart';
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
        return l10n.invalid_credentials_please_try_again;
      case LoginError.none:
        return '';
    }
  }

  factory LoginError.fromFirebaseAuthError(FirebaseAuthErrors error) {
    switch (error) {
      case FirebaseAuthErrors.emailAlreadyInUse:
        return LoginError.alreadyRegistered;
      case FirebaseAuthErrors.unknown:
        return LoginError.unknown;
      case FirebaseAuthErrors.invalidPassword:
      case FirebaseAuthErrors.userNotFound:
      case FirebaseAuthErrors.invalidCredetentials:
        return LoginError.invalidCredentials;
    }
  }
}

class LoginState extends Equatable {
  const LoginState({
    this.status = LoginStatus.disconnected,
    this.error = LoginError.none,
    this.info = '',
  });

  final LoginStatus status;
  final LoginError error;
  final String info;

  @override
  List<Object?> get props => [status, error, info];

  LoginState copyWith({LoginStatus? status, LoginError? error, String? info}) =>
      LoginState(
        status: status ?? this.status,
        error: error ?? this.error,
        info: info ?? this.info,
      );

  LoginState logout() => const LoginState(
    status: LoginStatus.disconnected,
    error: LoginError.none,
  );
}
