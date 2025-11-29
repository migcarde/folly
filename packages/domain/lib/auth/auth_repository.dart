import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/auth/auth_repository_impl.dart';
import 'package:domain/auth/models/auth_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class AuthRepository {
  Future<Result<AuthEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<Result<void>> logout();
  Future<Result<AuthEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<AuthEntity?> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<Result<void>> deleteAccount();
  Future<Result<void>> reauthenticate({
    required String email,
    required String password,
  });
  Future<Result<void>> sendPasswordResetEmail({required String email});
}

final authRepositoryProvider = Provider.autoDispose<AuthRepository>(
  (ref) => AuthRepositoryImpl(
    remoteDatasource: ref.watch(authRemoteDatasourceProvider),
  ),
);
