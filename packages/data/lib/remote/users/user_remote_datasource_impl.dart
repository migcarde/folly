import 'dart:io';

import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:data/remote/users/user_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDatasourceImpl extends UserRemoteDataSource {
  static const _usersCollection = 'Users';

  final Supabase _instance = Supabase.instance;

  @override
  Future<UserRemoteEntity> createUser({
    required UserRemoteEntity user,
    File? photo,
  }) async {
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

    final result = await _instance.client
        .from(_usersCollection)
        .insert(userToCreate.toJson())
        .select()
        .single();

    return UserRemoteEntity.fromJson(json: result);
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

    final user = UserRemoteEntity.fromJson(json: result);

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

  @override
  Future<PageRemoteEntity<UserRemoteEntity>> searchUser({
    required String query,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _instance.client
        .from(_usersCollection)
        .select()
        .or('username.ilike.%$query%,display_name.ilike.%$query%')
        .range(startIndex, endIndex)
        .count();

    final users = result.data.map((json) {
      final user = UserRemoteEntity.fromJson(json: json);
      if (user.photoPath != null && user.photoPath!.isNotEmpty) {
        final imageUrl = _instance.client.storage
            .from('profile')
            .getPublicUrl(user.photoPath!);

        return user.copyWith(photoPath: imageUrl);
      } else {
        return user;
      }
    }).toList();

    return PageRemoteEntity(
      content: users,
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<List<UserRemoteEntity>> getUsers({required List<String> uids}) async {
    final result = await _instance.client
        .from(_usersCollection)
        .select()
        .inFilter('id', uids);

    final users = result.map((json) {
      final user = UserRemoteEntity.fromJson(json: json);
      if (user.photoPath != null && user.photoPath!.isNotEmpty) {
        final imageUrl = _instance.client.storage
            .from('profile')
            .getPublicUrl(user.photoPath!);

        return user.copyWith(photoPath: imageUrl);
      } else {
        return user;
      }
    }).toList();

    return users;
  }
}
