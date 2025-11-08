import 'package:domain/login/login_repository.dart';
import 'package:domain/login/models/firebase_user_entity.dart';
import 'package:riverpod/riverpod.dart';

class AuthListener {
  final LoginRepository loginRepository;

  const AuthListener({required this.loginRepository});

  Stream<FirebaseUserEntity?> call() => loginRepository.listenChanges();
}

final authListenerProvider = Provider.autoDispose<AuthListener>(
  (ref) => AuthListener(loginRepository: ref.watch(loginRepositoryProvider)),
);
