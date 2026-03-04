import 'package:data/data.dart';
import 'package:data/remote/notifications/models/follow_notification_remote_entity.dart';
import 'package:data/remote/notifications/notifications_remote_datasource.dart';
import 'package:domain/base/domain_constants.dart';
import 'package:domain/base/result.dart';
import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:domain/friends/friends_repository.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/users/models/user_entity.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FriendsRemoteDatasource friendRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;
  final NotificationsRemoteDatasource notificationsRemoteDatasource;

  const FriendsRepositoryImpl({
    required this.friendRemoteDatasource,
    required this.userRemoteDatasource,
    required this.notificationsRemoteDatasource,
  });

  @override
  Future<Result<void>> accept({required FriendEntity request}) async {
    try {
      await friendRemoteDatasource.updateFriend(
        friend: request.copyWith(state: FriendRequestState.friend).remoteEntity,
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> delete({required String id}) async {
    try {
      await friendRemoteDatasource.deleteRequest(id: id);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> reject({required FriendEntity request}) async {
    try {
      await friendRemoteDatasource.updateFriend(
        friend: request.copyWith(state: FriendRequestState.none).remoteEntity,
      );
      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<FriendEntity>> sendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      final result = await friendRemoteDatasource.sendFriendRequest(
        senderId: senderId,
        receiverId: receiverId,
      );

      await notificationsRemoteDatasource.createNotification(
        functionName: NotificationType.follow.functionName,
        notification: FollowNotificationRemoteEntity(
          id: DomainConstants.noId,
          type: NotificationType.follow.value,
          createdAt: DateTime.now(),
          receiverUserId: receiverId,
          senderUserId: senderId,
        ),
      );

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<FriendEntity?>> getFriend({required String uid}) async {
    try {
      final result = await friendRemoteDatasource.getFriend(uid: uid);

      return Result.success(result?.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getFollowersCount({required String uid}) async {
    try {
      final result = await friendRemoteDatasource.getFollowersCount(uid: uid);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getFollowingCount({required String uid}) async {
    try {
      final result = await friendRemoteDatasource.getFollowingCount(uid: uid);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<UserEntity>>> getFollowers({
    required String uid,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      final followersResult = await friendRemoteDatasource.getFollowers(
        uid: uid,
        page: page,
        size: size,
        total: total,
      );

      final uids = _getUids(uid: uid, friends: followersResult.content);

      final result = await userRemoteDatasource.getUsers(uids: uids);

      return Result.success(
        PageEntity(
          content: result.map((user) => user.entity).toList(),
          page: followersResult.page,
          totalPages: followersResult.totalPages,
          total: followersResult.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<UserEntity>>> getFollowing({
    required String uid,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      final followingResult = await friendRemoteDatasource.getFollowing(
        uid: uid,
        page: page,
        size: size,
        total: total,
      );

      final uids = _getUids(uid: uid, friends: followingResult.content);

      final result = await userRemoteDatasource.getUsers(uids: uids);

      return Result.success(
        PageEntity(
          content: result.map((user) => user.entity).toList(),
          page: followingResult.page,
          totalPages: followingResult.totalPages,
          total: followingResult.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  List<String> _getUids({
    required String uid,
    required List<FriendRemoteEntity> friends,
  }) => friends.map((friend) {
    if (friend.uid == uid) {
      return friend.receiverUid;
    } else {
      return friend.uid;
    }
  }).toList();
}
