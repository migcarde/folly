import 'dart:io';

import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/users/models/user_remote_entity.dart';

abstract class UserRemoteDataSource {
  Future<UserRemoteEntity> createUser({
    required UserRemoteEntity user,
    File? photo,
  });
  Future<UserRemoteEntity> getUser({required String uid});
  Future<void> deleteUser({required String uid});
  Future<void> saveUser({required UserRemoteEntity user, File? photo});
  Future<PageRemoteEntity<UserRemoteEntity>> searchUser({
    required String query,
    required int page,
    int size = 10,
    int? total,
  });
  Future<List<UserRemoteEntity>> getUsers({required List<String> uids});
  Future<bool> isUsernameAvailable({required String username});
}
