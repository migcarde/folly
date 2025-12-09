import 'package:data/remote/friends/models/request_remote_entity.dart';

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
}
