import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/auth/models/auth_exceptions.dart';
import 'package:domain/base/result.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final AuthRemoteDatasource loginRemoteDatasource;

  UserRepositoryImpl({
    required this.userRemoteDataSource,
    required this.loginRemoteDatasource,
  });

  @override
  Future<Result<void>> deleteUser({required String uid}) async {
    try {
      final result = await userRemoteDataSource.deleteUser(uid: uid);

      return Result.success(result);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser({required String uid}) async {
    try {
      final result = await userRemoteDataSource.getUser(uid: uid);

      return Result.success(result.entity);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> editUser({
    required UserEntity user,
    File? photo,
    String? password,
  }) async {
    try {
      if (password != null && password.isNotEmpty) {
        loginRemoteDatasource.updatePassword(password: password);
      }

      final result = await userRemoteDataSource.saveUser(
        user: user.remoteEntity,
        photo: photo,
      );

      return Result.success(result);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> createUser({
    required CreateUserEntity user,
    File? photo,
  }) async {
    try {
      final authResult = await loginRemoteDatasource
          .createUserWithEmailAndPassword(
            email: user.data.email,
            password: user.password,
          );

      final newUser = user.data.copyWith(uid: authResult.uid);

      await userRemoteDataSource.createUser(
        user: newUser.remoteEntity,
        photo: photo,
      );

      return Result.success(newUser);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<UserEntity>>> searchUsers({
    required String query,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      final result = await userRemoteDataSource.searchUser(
        query: query,
        page: page,
        size: size,
        total: total,
      );

      return Result.success(
        PageEntity(
          content: result.content.map((user) => user.entity).toList(),
          page: result.page,
          totalPages: result.totalPages,
          total: result.total,
        ),
      );
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> isUsernameAvailable({required String username}) async {
    try {
      final result = await userRemoteDataSource.isUsernameAvailable(
        username: username,
      );

      return Result.success(result);
    } on AuthRemoteException catch (e) {
      return Result.failure(AuthException.fromRemoteException(exception: e));
    } catch (e) {
      return Result.failure(e);
    }
  }
}
