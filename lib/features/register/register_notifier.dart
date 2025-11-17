import 'package:domain/domain.dart';
import 'package:domain/login/models/firebase_auth_errors.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/extensions/string_extensions.dart';
import 'package:folly/features/register/models/register_state.dart';

class RegisterNotifier extends StateNotifier<RegisterState> {
  RegisterNotifier({required this.createUser}) : super(RegisterState());

  final CreateUser createUser;

  Future<void> register({
    required UserEntity user,
    required String password,
    required String repeatPassword,
  }) async {
    List<RegisterError> errors = [
      if (!user.email.isValidEmail) RegisterError.emailNotValid,
      if (!password.isStrongPassword) RegisterError.passwordMustBeStronger,
      if (password != repeatPassword) RegisterError.passwordNotMatch,
    ];

    if (errors.isNotEmpty) {
      state = state.copyWith(status: RegisterStatus.initial, errors: errors);
    } else {
      state = state.copyWith(status: RegisterStatus.loading);

      _createUser(
        user: CreateUserEntity(data: user, password: password),
      );
    }
  }

  Future<void> _createUser({required CreateUserEntity user}) async {
    final result = await createUser(user);

    result.when(
      (user) => state = state.copyWith(status: RegisterStatus.success),
      (failure) =>
          _onError(failure), // TODO: Check userename availability error
    );
  }

  void _onError(Object failure) {
    if (failure is FirebaseAuthErrors) {
      final registerError = RegisterError.fromFirebaseAuthError(failure);

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
      (ref) => RegisterNotifier(createUser: ref.watch(createUserProvider)),
    );
