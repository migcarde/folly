import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/login/login_repository.dart';
import 'package:domain/login/models/firebase_user_entity.dart';
import 'package:domain/login/models/login_entity.dart';
import 'package:riverpod/riverpod.dart';

class Login implements BaseUseCase<FirebaseUserEntity, LoginEntity> {
  final LoginRepository loginRepository;

  const Login({required this.loginRepository});

  @override
  Future<Result<FirebaseUserEntity>> call(LoginEntity params) async =>
      loginRepository.loginWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
}

final loginProvider = Provider.autoDispose<Login>(
  (ref) => Login(loginRepository: ref.watch(loginRepositoryProvider)),
);
