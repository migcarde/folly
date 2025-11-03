import 'package:data/remote/users/user_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Result<void>> deleteUser({required String uid}) async {
    try {
      final result = await remoteDataSource.deleteUser(uid: uid);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<UserEntity>> getUser({required String uid}) async {
    try {
      final result = await remoteDataSource.getUser(uid: uid);

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> saveUser({required UserEntity user}) async {
    try {
      final result = await remoteDataSource.saveUser(user: user.remoteEntity);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
