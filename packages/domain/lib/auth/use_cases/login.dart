import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/models/auth_entity.dart';
import 'package:domain/auth/models/login_entity.dart';
import 'package:riverpod/riverpod.dart';

class Login implements BaseUseCase<AuthEntity, LoginEntity> {
  final AuthRepository loginRepository;

  const Login({required this.loginRepository});

  @override
  Future<Result<AuthEntity>> call(LoginEntity params) async =>
      loginRepository.loginWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
}

final loginProvider = Provider.autoDispose<Login>(
  (ref) => Login(loginRepository: ref.watch(authRepositoryProvider)),
);
