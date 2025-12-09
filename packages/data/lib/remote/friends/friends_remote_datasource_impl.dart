import 'package:data/remote/friends/models/request_remote_entity.dart';
import 'package:data/remote/friends/friends_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FriendsRemoteDatasourceImpl implements FriendsRemoteDatasource {
  static const _friendsCollections = 'Friends';

  final Supabase _instance = Supabase.instance;

  @override
  Future<void> deleteRequest({required String id}) async =>
      await _instance.client.from(_friendsCollections).delete().eq('id', id);

  @override
  Future<FriendRemoteEntity> sendFriendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    final requestRemoteEntity = FriendRemoteEntity(
      id: '',
      uid: senderId,
      receiverUid: receiverId,
      state: 1,
    );

    final result = await _instance.client
        .from(_friendsCollections)
        .insert(requestRemoteEntity.toJson())
        .select()
        .single();

    return FriendRemoteEntity.fromJson(json: result);
  }

  @override
  Future<List<FriendRemoteEntity>> getRequests({required String uid}) async {
    final result = await _instance.client
        .from(_friendsCollections)
        .select()
        .eq('receiver_uid', uid);

    return result
        .map((json) => FriendRemoteEntity.fromJson(json: json))
        .toList();
  }

  @override
  Future<List<FriendRemoteEntity>> getPendingRequests({
    required String uid,
  }) async {
    final result = await _instance.client
        .from(_friendsCollections)
        .select()
        .eq('uid', uid);

    return result
        .map((json) => FriendRemoteEntity.fromJson(json: json))
        .toList();
  }

  @override
  Future<FriendRemoteEntity?> getFriend({required String uid}) async {
    final result = await _instance.client
        .from(_friendsCollections)
        .select()
        .or('uid.eq.$uid,receiver_uid.eq.$uid')
        .maybeSingle();

    return result == null ? null : FriendRemoteEntity.fromJson(json: result);
  }

  @override
  Future<void> updateFriend({required FriendRemoteEntity friend}) async =>
      await _instance.client
          .from(_friendsCollections)
          .update(friend.toJson())
          .eq('id', friend.id);

  @override
  Future<int> getFollowersCount({required String uid}) async {
    final result = await _instance.client
        .from(_friendsCollections)
        .select()
        .eq('receiver_uid', uid)
        .count(CountOption.exact);

    return result.count;
  }

  @override
  Future<int> getFollowingCount({required String uid}) async {
    final result = await _instance.client
        .from(_friendsCollections)
        .select()
        .eq('uid', uid)
        .count(CountOption.exact);

    return result.count;
  }
}
