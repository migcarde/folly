import 'package:domain/base/result.dart';
import 'package:domain/users/models/user_entity.dart';

abstract class UserRepository {
  Future<Result<UserEntity>> getUser({required String uid});
  Future<Result<void>> saveUser({required UserEntity user});
  Future<Result<void>> deleteUser({required String uid});
}
