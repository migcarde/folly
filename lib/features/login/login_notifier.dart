import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/login/models/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier({required this.authRepository}) : super(const LoginState());

  final AuthRepository authRepository;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: LoginStatus.loading, error: LoginError.none);

    final result = await authRepository.loginWithEmailAndPassword(
      email: email,
      password: password,
    );

    result.when(
      (user) {},
      (failure, __) => state = state.copyWith(
        status: LoginStatus.disconnected,
        error: failure is AuthException
            ? LoginError.fromAuthException(exception: failure)
            : LoginError.unknown,
      ),
    );
  }
}

final loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(authRepository: ref.watch(authRepositoryProvider)),
    );
