import 'dart:io';

import 'package:domain/auth/auth_repository.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/edit_profile/models/edit_profile_state.dart';

class EditProfileNotifier extends StateNotifier<EditProfileState> {
  EditProfileNotifier({
    required this.authNotifier,
    required this.userRepository,
    required this.authRepository,
  }) : super(const EditProfileState());

  final AuthNotifier authNotifier;
  final UserRepository userRepository;
  final AuthRepository authRepository;

  Future<void> init() async {
    state = state.copyWith(status: EditProfileStatus.loading);

    final user = authNotifier.user;
    if (user != null) {
      state = state.copyWith(status: EditProfileStatus.data, user: user);
    }
  }

  void loadPhoto({required File file}) => state = state.copyWith(file: file);

  Future<void> updateUser({
    String? name,
    String? biography,
    File? file,
    String? password,
    String? repeatPassword,
  }) async {
    state = state.copyWith(status: EditProfileStatus.uploadingProfile);

    if ((password == null || password.isEmpty) &&
        password?.isNotEmpty == true) {
      state = state.copyWith(
        status: EditProfileStatus.data,
        error: EditProfileError.passwordEmpty,
      );
    } else if (password?.isNotEmpty == true &&
        (repeatPassword == null || repeatPassword.isEmpty)) {
      state = state.copyWith(
        status: EditProfileStatus.data,
        error: EditProfileError.repeatPasswordEmpty,
      );
    } else if (password != repeatPassword) {
      state = state.copyWith(
        status: EditProfileStatus.data,
        error: EditProfileError.passwordNotMatch,
      );
    } else {
      final result = await userRepository.saveUser(
        user: state.user!.copyWith(name: name, biography: biography),
        photo: file,
        password: password,
      );

      result.when(
        (_) {
          authNotifier.update();
          state = state.copyWith(
            status: EditProfileStatus.success,
            error: EditProfileError.none,
          );
        },
        (_) => state = state.copyWith(
          status: EditProfileStatus.error,
          error: EditProfileError.none,
        ),
      );
    }
  }

  Future<void> sendPasswordResetEmail() async {
    if (state.user != null) {
      final result = await authRepository.sendPasswordResetEmail(
        email: state.user!.email,
      );

      result.when(
        (_) => state = state.copyWith(
          status: EditProfileStatus.sendPasswordResetEmail,
        ),
        (_) => state = state.copyWith(status: EditProfileStatus.error),
      );
    }
  }

  void reset() => state = state.copyWith(status: EditProfileStatus.data);
}

final editProfileProvider =
    StateNotifierProvider<EditProfileNotifier, EditProfileState>(
      (ref) => EditProfileNotifier(
        authNotifier: ref.watch(authNotifierProvider),
        userRepository: ref.watch(userRepositoryProvider),
        authRepository: ref.watch(authRepositoryProvider),
      ),
    );
