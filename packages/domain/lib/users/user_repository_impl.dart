import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/login/models/firebase_auth_errors.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource userRemoteDataSource;
  final LoginRemoteDatasource loginRemoteDatasource;

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
  }) async {
    try {
      final firebaseUserResult = await loginRemoteDatasource
          .createUserWithEmailAndPassword(
            email: user.data.email,
            password: user.password,
          );

      final newUser = user.data.copyWith(uid: firebaseUserResult.uid);

      await userRemoteDataSource.saveUser(user: newUser.remoteEntity);

      return Result.success(newUser);
    } on FirebaseAuthException catch (e) {
      return Result.failure(FirebaseAuthErrors.fromString(e.code));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<bool>> checkUsernameAvailability({
    required String username,
  }) async {
    try {
      final result = await userRemoteDataSource.checkUsernameAvailability(
        username: username,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
