import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/login/login_repository_impl.dart';
import 'package:domain/login/models/firebase_user_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class LoginRepository {
  Future<Result<FirebaseUserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
  Future<Result<FirebaseUserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<FirebaseUserEntity?> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<Result<void>> deleteAccount();
  Future<Result<void>> reauthenticate({
    required String email,
    required String password,
  });
}

final loginRepositoryProvider = Provider<LoginRepository>(
  (ref) => LoginRepositoryImpl(
    remoteDatasource: ref.watch(loginRemoteDatasourceProvider),
  ),
);
