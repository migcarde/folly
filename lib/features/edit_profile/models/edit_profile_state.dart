import 'dart:io';

import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:folly/l10n/app_localizations.dart';

enum EditProfileStatus {
  loading,
  data,
  uploadingProfile,
  success,
  sendPasswordResetEmail,
  error;

  bool get isError => this == EditProfileStatus.error;
  bool get isLoading => this == EditProfileStatus.loading;
  bool get isSuccess => this == EditProfileStatus.success;
  bool get isSendPasswordResetEmail =>
      this == EditProfileStatus.sendPasswordResetEmail;
  bool get isData => this == EditProfileStatus.data;
  bool get isUploadingProfile => this == EditProfileStatus.uploadingProfile;
}

enum EditProfileError {
  passwordNotMatch,
  passwordEmpty,
  repeatPasswordEmpty,
  none;

  bool get isPasswordError =>
      this == EditProfileError.passwordNotMatch ||
      this == EditProfileError.passwordEmpty;
  bool get isRepeatPasswordEmpty =>
      this == EditProfileError.repeatPasswordEmpty;

  String getText({required AppLocalizations l10n}) {
    switch (this) {
      case EditProfileError.passwordNotMatch:
        return l10n.password_does_not_match;
      case EditProfileError.passwordEmpty:
        return l10n.required_field;
      case EditProfileError.repeatPasswordEmpty:
        return l10n.required_field;
      case EditProfileError.none:
        return '';
    }
  }
}

class EditProfileState extends Equatable {
  final EditProfileStatus status;
  final UserEntity? user;
  final File? file;
  final EditProfileError error;

  const EditProfileState({
    this.status = EditProfileStatus.loading,
    this.user,
    this.file,
    this.error = EditProfileError.none,
  });

  @override
  List<Object?> get props => [status, user, file, error];

  EditProfileState copyWith({
    EditProfileStatus? status,
    UserEntity? user,
    File? file,
    EditProfileError? error,
  }) => EditProfileState(
    status: status ?? this.status,
    user: user ?? this.user,
    file: file ?? this.file,
    error: error ?? this.error,
  );
}
