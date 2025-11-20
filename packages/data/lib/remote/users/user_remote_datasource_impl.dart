import 'dart:io';

import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:data/remote/users/user_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDatasourceImpl extends UserRemoteDataSource {
  static const _usersCollection = 'Users';

  final Supabase _instance = Supabase.instance;

  @override
  Future<void> createUser({required UserRemoteEntity user, File? photo}) async {
    UserRemoteEntity userToCreate = user;
    if (photo != null) {
      final fileBytes = await photo.readAsBytes();
      final path =
          '${user.uid}/profile-${DateTime.now().toIso8601String()}-${photo.path.split('/').last}';
      await _instance.client.storage
          .from('profile')
          .uploadBinary(path, fileBytes);

      userToCreate = user.copyWith(photoPath: path);
    }

    await _instance.client.from(_usersCollection).insert(userToCreate.toJson());
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    await _instance.client.from(_usersCollection).delete().eq('id', uid);
  }

  @override
  Future<UserRemoteEntity> getUser({required String uid}) async {
    final result = await _instance.client
        .from(_usersCollection)
        .select()
        .eq('id', uid)
        .single();

    final user = UserRemoteEntity.fromJson(uid: uid, json: result);

    if (user.photoPath != null && user.photoPath!.isNotEmpty) {
      final imageUrl = _instance.client.storage
          .from('profile')
          .getPublicUrl(user.photoPath!);

      return user.copyWith(photoPath: imageUrl);
    }

    return user;
  }

  @override
  Future<void> saveUser({required UserRemoteEntity user, File? photo}) async {
    UserRemoteEntity userToUpdate = user;

    if (photo != null) {
      if (user.photoPath != null && user.photoPath!.isNotEmpty) {
        await _instance.client.storage.from('profile').remove([
          user.photoPath!,
        ]);
      }
      final fileBytes = await photo.readAsBytes();
      final path =
          '${user.uid}/profile-${DateTime.now().toIso8601String()}-${photo.path.split('/').last}';
      await _instance.client.storage
          .from('profile')
          .uploadBinary(path, fileBytes);

      userToUpdate = user.copyWith(photoPath: path);
    }

    await _instance.client
        .from(_usersCollection)
        .update(userToUpdate.toJson())
        .eq('id', user.uid);
  }
}
