import 'package:domain/login/auth_repository.dart';
import 'package:domain/login/models/auth_entity.dart';
import 'package:riverpod/riverpod.dart';

class AuthListener {
  final AuthRepository loginRepository;

  const AuthListener({required this.loginRepository});

  Stream<AuthEntity?> call() => loginRepository.listenChanges();
}

final authListenerProvider = Provider.autoDispose<AuthListener>(
  (ref) => AuthListener(loginRepository: ref.watch(loginRepositoryProvider)),
);
