import 'dart:io';

import 'package:data/remote/users/models/user_remote_entity.dart';

abstract class UserRemoteDataSource {
  Future<void> saveUser({required UserRemoteEntity user, File? photo});
  Future<UserRemoteEntity> getUser({required String uid});
  Future<void> deleteUser({required String uid});
}
