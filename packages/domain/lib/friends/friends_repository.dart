import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/friends/friends_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

abstract class FriendsRepository {
  Future<Result<void>> sendRequest({
    required String senderId,
    required String receiverId,
  });
  Future<Result<void>> delete({required String id});
  Future<Result<void>> accept({required FriendEntity request});
  Future<Result<void>> reject({required FriendEntity request});
  Future<Result<FriendEntity?>> getFriend({required String uid});
}

final friendsRepositoryProvider = Provider.autoDispose<FriendsRepository>(
  (ref) => FriendsRepositoryImpl(
    friendRemoteDatasource: ref.watch(friendsRemoteDatasurceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
  ),
);
