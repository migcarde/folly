import 'dart:io';

import 'package:domain/login/models/firebase_auth_errors.dart';
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
  nameEmpty,
  passwordNotMatch,
  passwordMustBeStronger,
  usernameAlreadyInUse,
  unknown,
  none;

  bool get isEmailNotValid => this == RegisterError.emailNotValid;
  bool get isEmailAlreayInUse => this == RegisterError.emailAlreadyInUse;
  bool get isNameEmpty => this == RegisterError.nameEmpty;
  bool get isPasswordError => this == RegisterError.passwordNotMatch;
  bool get isPasswordMustBeStronger =>
      this == RegisterError.passwordMustBeStronger;
  bool get isUnknown => this == RegisterError.unknown;

  String getMessage(BuildContext context) {
    final l10n = context.l10n;

    switch (this) {
      case RegisterError.emailNotValid:
        return l10n.email_not_valid;
      case RegisterError.emailAlreadyInUse:
        return l10n.user_already_registered_please_use_another_email;
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
      case RegisterError.none:
        return '';
    }
  }

  factory RegisterError.fromFirebaseAuthError(FirebaseAuthErrors error) {
    switch (error) {
      case FirebaseAuthErrors.emailAlreadyInUse:
        return RegisterError.emailAlreadyInUse;
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
