import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/login/login_repository.dart';
import 'package:domain/login/models/firebase_auth_errors.dart';
import 'package:domain/login/models/firebase_user_entity.dart';

class LoginRepositoryImpl extends LoginRepository {
  final LoginRemoteDatasource remoteDatasource;

  LoginRepositoryImpl({required this.remoteDatasource});

  @override
  Future<Result<FirebaseUserEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.entity);
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await remoteDatasource.deleteAccount();

      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  bool get isLoggedIn => remoteDatasource.isLoggedIn;

  @override
  Stream<FirebaseUserEntity?> listenChanges() async* {
    await for (final remoteUser in remoteDatasource.listenChanges()) {
      yield remoteUser?.entity;
    }
  }

  @override
  Future<Result<FirebaseUserEntity>> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await remoteDatasource.loginWithEmailAndPassword(
        email: email,
        password: password,
      );

      return Result.success(result.entity);
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remoteDatasource.logout();

      return Result.success(null);
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
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
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  String get uid => remoteDatasource.uid;
}
