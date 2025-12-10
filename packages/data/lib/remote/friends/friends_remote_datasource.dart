import 'package:data/remote/friends/models/request_remote_entity.dart';
import 'package:data/remote/models/page_remote_entity.dart';

abstract class FriendsRemoteDatasource {
  Future<FriendRemoteEntity> sendFriendRequest({
    required String senderId,
    required String receiverId,
  });
  Future<void> deleteRequest({required String id});
  Future<List<FriendRemoteEntity>> getRequests({required String uid});
  Future<List<FriendRemoteEntity>> getPendingRequests({required String uid});
  Future<FriendRemoteEntity?> getFriend({required String uid});
  Future<void> updateFriend({required FriendRemoteEntity friend});
  Future<int> getFollowersCount({required String uid});
  Future<int> getFollowingCount({required String uid});
  Future<PageRemoteEntity<FriendRemoteEntity>> getFollowers({
    required String uid,
    required int page,
    int size = 10,
    int? total,
  });
  Future<PageRemoteEntity<FriendRemoteEntity>> getFollowing({
    required String uid,
    required int page,
    int size = 10,
    int? total,
  });
}
