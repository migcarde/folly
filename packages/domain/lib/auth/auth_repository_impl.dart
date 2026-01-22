import 'package:data/data.dart';
import 'package:domain/auth/enums/auth_event_status.dart';
import 'package:domain/auth/models/auth_event_entity.dart';
import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:domain/base/result.dart';
import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/models/auth_entity.dart';

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
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await remoteDatasource.deleteAccount();

      return Result.success(null);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  bool get isLoggedIn => remoteDatasource.isLoggedIn;

  @override
  Stream<AuthEventEntity> listenChanges() async* {
    await for (final event in remoteDatasource.listenChanges()) {
      yield AuthEventEntity(
        status: event.status.eventStatus,
        auth: event.user?.entity,
      );
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
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> logout() async {
    try {
      await remoteDatasource.logout();

      return Result.success(null);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
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
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  String get uid => remoteDatasource.uid;

  @override
  Future<Result<void>> sendPasswordResetEmail({required String email}) async {
    try {
      await remoteDatasource.sendPasswordResetEmail(email: email);

      return Result.success(null);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updatePassword({required String password}) async {
    try {
      await remoteDatasource.updatePassword(password: password);

      return Result.success(null);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
