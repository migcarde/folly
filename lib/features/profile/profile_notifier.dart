import 'package:domain/base/result.dart';
import 'package:domain/domain.dart';
import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/profile/models/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier({
    required this.storiesRepository,
    required this.friendsRepository,
    required this.authNotifier,
  }) : super(const ProfileState());

  final StoriesRepository storiesRepository;
  final FriendsRepository friendsRepository;
  final AuthNotifier authNotifier;

  Future<void> init({
    required UserEntity user,
    required bool isCurrentUser,
  }) async {
    state = state.copyWith(status: ProfileStatus.loading);

    final result = await Future.wait([
      storiesRepository.getStoriesFromUser(user: user),
      friendsRepository.getFollowersCount(uid: user.uid),
      friendsRepository.getFollowingCount(uid: user.uid),
      if (!isCurrentUser && authNotifier.user != null)
        friendsRepository.getFriend(uid: user.uid),
    ]);

    final storiesResult = result[0] as Result<List<StoryEntity>>;
    final followersResult = result[1] as Result<int>;
    final followingResult = result[2] as Result<int>;
    final pendingResult = (result.length > 3)
        ? (result[3] as Result<FriendEntity?>)
        : Result.success(null);

    storiesResult.when((stories) {
      FriendEntity? friendRequest = pendingResult.when(
        (value) => value,
        (_) => null,
      );

      if (authNotifier.user != null &&
          friendRequest != null &&
          friendRequest.state == FriendRequestState.following &&
          friendRequest.receiverUid == authNotifier.user!.uid) {
        friendRequest = friendRequest.copyWith(
          state: FriendRequestState.requested,
        );
      }

      state = state.copyWith(
        status: ProfileStatus.success,
        stories: stories,
        friend: friendRequest,
        followers: followersResult.when((value) => value, (_) => 0),
        following: followingResult.when((value) => value, (_) => 0),
      );
    }, (_) => state = state.copyWith(status: ProfileStatus.error));
  }

  Future<void> sendRequest({required String receiverId}) async {
    if (authNotifier.user != null) {
      final result = await friendsRepository.sendRequest(
        senderId: authNotifier.user!.uid,
        receiverId: receiverId,
      );

      result.when(
        (data) => state = state.copyWith(
          friend: data,
          followers: state.followers + 1,
        ),
        (_) => state = state.copyWith(status: ProfileStatus.error),
      );
    }
  }

  Future<void> acceptRequest() async {
    if (state.friend != null) {
      final result = await friendsRepository.accept(request: state.friend!);

      result.when(
        (_) => state = state.copyWith(
          friend: state.friend?.copyWith(state: FriendRequestState.friend),
          following: state.following + 1,
        ),
        (_) {},
      );
    }
  }

  Future<void> rejectRequest() async {
    if (state.friend != null) {
      final result = await friendsRepository.reject(request: state.friend!);

      result.when((_) => state = state.clearRequest(), (_) {});
    }
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      (ref) => ProfileNotifier(
        storiesRepository: ref.watch(storiesRepositoryProvider),
        friendsRepository: ref.watch(friendsRepositoryProvider),
        authNotifier: ref.watch(authNotifierProvider),
      ),
    );
