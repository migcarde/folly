import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> createUser({required CreateUserEntity user});
  Future<Result<UserEntity>> getUser({required String uid});
  Future<Result<void>> saveUser({required UserEntity user});
  Future<Result<void>> deleteUser({required String uid});
}

final userRepositoryProvider = Provider.autoDispose<UserRepository>(
  (ref) => UserRepositoryImpl(
    userRemoteDataSource: ref.watch(userRemoteDatasourceProvider),
    loginRemoteDatasource: ref.watch(authRemoteDatasourceProvider),
  ),
);
