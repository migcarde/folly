import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:domain/friends/friends_repository.dart';
import 'package:domain/friends/models/friend_entity.dart';

class FriendsRepositoryImpl implements FriendsRepository {
  final FriendsRemoteDatasource friendRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;

  const FriendsRepositoryImpl({
    required this.friendRemoteDatasource,
    required this.userRemoteDatasource,
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
  Future<Result<int>> getFollowers({required String uid}) async {
    try {
      final result = await friendRemoteDatasource.getFollowersCount(uid: uid);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getFollowing({required String uid}) async {
    try {
      final result = await friendRemoteDatasource.getFollowingCount(uid: uid);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
