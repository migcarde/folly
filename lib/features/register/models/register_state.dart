import 'dart:io';

import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';

enum RegisterStatus {
  initial,
  error,
  success,
  loading;

  bool get isError => this == RegisterStatus.error;
  bool get isLoading => this == RegisterStatus.loading;
  bool get isSuccess => this == RegisterStatus.success;
}

enum RegisterError {
  emailNotValid,
  emailAlreadyInUse,
  userBanned,
  nameEmpty,
  passwordNotMatch,
  passwordMustBeStronger,
  usernameAlreadyInUse,
  passwordRequired,
  usernameRequired,
  unknown,
  none;

  bool get isEmailNotValid => this == RegisterError.emailNotValid;
  bool get isEmailAlreayInUse => this == RegisterError.emailAlreadyInUse;
  bool get isUserBanned => this == RegisterError.userBanned;
  bool get isNameEmpty => this == RegisterError.nameEmpty;
  bool get isPasswordError => this == RegisterError.passwordNotMatch;
  bool get isPasswordMustBeStronger =>
      this == RegisterError.passwordMustBeStronger;
  bool get isPasswordRequired => this == RegisterError.passwordRequired;
  bool get isUsernameAlreadyInUse => this == RegisterError.usernameAlreadyInUse;
  bool get isUsernameRequired => this == RegisterError.usernameRequired;
  bool get isUnknown => this == RegisterError.unknown;

  String getMessage(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case RegisterError.emailNotValid:
        return l10n.email_not_valid;
      case RegisterError.emailAlreadyInUse:
        return l10n.user_already_registered_please_use_another_email;
      case RegisterError.userBanned:
        return l10n.user_banned;
      case RegisterError.nameEmpty:
        return l10n.name_is_required;
      case RegisterError.passwordNotMatch:
        return l10n.password_does_not_match;
      case RegisterError.passwordMustBeStronger:
        return l10n.passwords_is_weak;
      case RegisterError.unknown:
        return l10n.sorry_we_have_problems_please_try_again_later;
      case RegisterError.usernameAlreadyInUse:
        return l10n.username_already_in_use;
      case RegisterError.usernameRequired:
      case RegisterError.passwordRequired:
        return l10n.required_field;
      case RegisterError.none:
        return '';
    }
  }

  factory RegisterError.fromAuthException({required AuthException exception}) {
    switch (exception) {
      case AuthException.invalidEmail:
        return RegisterError.emailNotValid;
      case AuthException.emailAlreadyInUse:
        return RegisterError.emailAlreadyInUse;
      case AuthException.userBanned:
        return RegisterError.userBanned;
      case AuthException.weakPassword:
        return RegisterError.passwordMustBeStronger;
      default:
        return RegisterError.unknown;
    }
  }
}

extension RegisterErrorsExtensions on List<RegisterError> {
  bool get hasEmailErrors =>
      contains(RegisterError.emailAlreadyInUse) ||
      contains(RegisterError.emailNotValid);

  String getEmailErrorMessage(BuildContext context) {
    final l10n = context.l10n;

    if (contains(RegisterError.emailNotValid)) {
      return l10n.email_not_valid;
    } else if (contains(RegisterError.emailAlreadyInUse)) {
      return l10n.user_already_registered_please_use_another_email;
    } else {
      return '';
    }
  }

  String getUsernameErrorMessage(BuildContext context) {
    final l10n = context.l10n;

    if (contains(RegisterError.usernameAlreadyInUse)) {
      return l10n.username_already_in_use;
    } else if (contains(RegisterError.usernameRequired)) {
      return l10n.required_field;
    } else {
      return '';
    }
  }

  String getPasswordErrorMessage(BuildContext context) {
    final l10n = context.l10n;

    if (contains(RegisterError.passwordNotMatch)) {
      return l10n.password_does_not_match;
    } else if (contains(RegisterError.passwordMustBeStronger)) {
      return l10n.passwords_is_weak;
    } else if (contains(RegisterError.passwordRequired)) {
      return l10n.required_field;
    } else {
      return '';
    }
  }
}

class RegisterState extends Equatable {
  const RegisterState({
    this.file,
    this.status = RegisterStatus.initial,
    this.errors = const [],
  });

  final File? file;
  final RegisterStatus status;
  final List<RegisterError> errors;

  @override
  List<Object> get props => [errors, status];

  RegisterState copyWith({
    File? file,
    RegisterStatus? status,
    List<RegisterError>? errors,
  }) => RegisterState(
    file: file ?? this.file,
    status: status ?? this.status,
    errors: errors ?? this.errors,
  );
}
