import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/extensions/string_extensions.dart';
import 'package:folly/features/login/models/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier({required this.authRepository}) : super(const LoginState());

  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: LoginStatus.loading, errors: []);

    final errors = [
      if (email.isEmpty) LoginError.emailRequired,
      if (!email.isValidEmail) LoginError.invalidEmail,
      if (password.isEmpty) LoginError.passwordRequired,
    ];

    if (errors.isNotEmpty) {
      state = state.copyWith(status: LoginStatus.disconnected, errors: errors);
    } else {
      final result = await authRepository.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      result.when((user) {}, (failure, __) => _onError(failure));
    }
  }

  void _onError(Object failure) {
    if (failure is AuthException) {
      state = state.copyWith(
        status: LoginStatus.disconnected,
        errors: [LoginError.fromAuthException(exception: failure)],
      );
    } else {
      state = state.copyWith(
        status: LoginStatus.disconnected,
        errors: [LoginError.unknown],
      );
    }
  }
}

final loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(authRepository: ref.watch(authRepositoryProvider)),
    );
