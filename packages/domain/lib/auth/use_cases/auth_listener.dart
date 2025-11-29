import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/models/auth_entity.dart';
import 'package:riverpod/riverpod.dart';

class AuthListener {
  final AuthRepository loginRepository;

  const AuthListener({required this.loginRepository});

  Stream<AuthEntity?> call() => loginRepository.listenChanges();
}

final authListenerProvider = Provider.autoDispose<AuthListener>(
  (ref) => AuthListener(loginRepository: ref.watch(authRepositoryProvider)),
);
