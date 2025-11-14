import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:data/remote/users/user_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRemoteDatasourceImpl extends UserRemoteDataSource {
  static const _usersCollection = 'Users';

  final Supabase _instance = Supabase.instance;

  @override
  Future<void> saveUser({required UserRemoteEntity user}) async {
    try {
      await _instance.client.from(_usersCollection).insert(user.toJson());
    } catch (e) {
      rethrow;
    }
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

    return UserRemoteEntity.fromJson(uid: uid, json: result);
  }
}
