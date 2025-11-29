import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:domain/auth/models/login_entity.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/login/models/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier({required this.loginUseCase}) : super(const LoginState());

  final Login loginUseCase;

  Future<void> login({required String email, required String password}) async {
    state = state.copyWith(status: LoginStatus.loading, error: LoginError.none);

    final result = await loginUseCase(
      LoginEntity(email: email, password: password),
    );

    result.when(
      (user) => state = state.copyWith(status: LoginStatus.connected),
      (failure) => state = state.copyWith(
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
      (ref) => LoginNotifier(loginUseCase: ref.watch(loginProvider)),
    );
