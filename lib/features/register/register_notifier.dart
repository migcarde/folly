import 'dart:io';

import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/extensions/string_extensions.dart';
import 'package:folly/features/register/models/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier({required this.userRepository}) : super(RegisterState());

  final UserRepository userRepository;

  Future<void> register({
    required UserEntity user,
    required String password,
    required String repeatPassword,
  }) async {
    state = state.copyWith(errors: []);
    List<RegisterError> errors = [
      if (!user.email.isValidEmail) RegisterError.emailNotValid,
      if (user.name.isEmpty) RegisterError.nameEmpty,
      if (user.username.isEmpty) RegisterError.usernameRequired,
      if (password.isEmpty) RegisterError.passwordRequired,
      if (password.isNotEmpty && !password.isStrongPassword)
        RegisterError.passwordMustBeStronger,
      if (password != repeatPassword) RegisterError.passwordNotMatch,
    ];

    if (errors.isNotEmpty) {
      state = state.copyWith(status: RegisterStatus.initial, errors: errors);
    } else {
      state = state.copyWith(status: RegisterStatus.loading);

      final isUsernameAvailableResult = await userRepository
          .isUsernameAvailable(username: user.username);

      await isUsernameAvailableResult.when((isAvailable) async {
        if (isAvailable) {
          await _createUser(
            user: CreateUserEntity(data: user, password: password),
          );
        } else {
          state = state.copyWith(
            status: RegisterStatus.initial,
            errors: [RegisterError.usernameAlreadyInUse],
          );
        }
      }, (failure, __) async => _onError(failure));
    }
  }

  void loadPhoto({required File file}) => state = state.copyWith(file: file);

  Future<void> _createUser({required CreateUserEntity user}) async {
    final result = await userRepository.createUser(
      user: user,
      photo: state.file,
    );

    result.when(
      (user) => state = state.copyWith(status: RegisterStatus.success),
      (failure, __) => _onError(failure),
    );
  }

  void _onError(Object failure) {
    if (failure is AuthException) {
      final registerError = RegisterError.fromAuthException(exception: failure);

      state = state.copyWith(
        status: registerError.isEmailAlreayInUse
            ? RegisterStatus.initial
            : RegisterStatus.error,
        errors: [registerError],
      );
    } else {
      state = state.copyWith(
        status: RegisterStatus.error,
        errors: [RegisterError.unknown],
      );
    }
  }
}

final registerNotifierProvider =
    StateNotifierProvider.autoDispose<RegisterNotifier, RegisterState>(
      (ref) =>
          RegisterNotifier(userRepository: ref.watch(userRepositoryProvider)),
    );
