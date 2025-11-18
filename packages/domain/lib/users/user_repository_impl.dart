import 'dart:io';

import 'package:data/data.dart';
import 'package:domain/base/result.dart';
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
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser({required String uid}) async {
    try {
      final result = await userRemoteDataSource.getUser(uid: uid);

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveUser({required UserEntity user}) async {
    try {
      final result = await userRemoteDataSource.saveUser(
        user: user.remoteEntity,
      );

      return Result.success(result);
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

      await userRemoteDataSource.saveUser(
        user: newUser.remoteEntity,
        photo: photo,
      );

      return Result.success(newUser);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
