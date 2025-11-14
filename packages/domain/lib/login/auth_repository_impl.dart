import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/login/auth_repository.dart';
import 'package:domain/login/models/auth_entity.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource remoteDatasource;

  AuthRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Result<AuthEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await remoteDatasource.deleteAccount();

      return Result.success(null);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  bool get isLoggedIn => remoteDatasource.isLoggedIn;

  @override
  Stream<AuthEntity?> listenChanges() async* {
    await for (final auth in remoteDatasource.listenChanges()) {
      yield auth?.entity;
    }
  }

  @override
  Future<Result<AuthEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.entity);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remoteDatasource.logout();

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> reauthenticate({
    required String email,
    required String password,
  }) async {
    try {
      await remoteDatasource.reauthenticate(email: email, password: password);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  String get uid => remoteDatasource.uid;
}
