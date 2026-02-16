import 'dart:async';

import 'package:domain/base/result.dart';
import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:domain/friends/friends_repository.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/stories/models/story_entity.dart';
import 'package:domain/stories/stories_repository.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/profile/models/profile_state.dart';

class ProfileAsyncNotifier extends AsyncNotifier<ProfileState> {
  final ProfileParams params;

  ProfileAsyncNotifier({required this.params});

  @override
  FutureOr<ProfileState> build() async {
    // TODO: Change this to get uid or user entity from parameters and get user if is uid or set it directle
    late UserEntity user;

    state = AsyncLoading();

    if (params.user != null) {
      user = params.user!;
    } else if (params.uid != null) {
      final userRepository = ref.watch(userRepositoryProvider);
      final userResult = await userRepository.getUser(uid: params.uid!);

      userResult.when((value) => user = value, (error, stackTrace) {
        state = AsyncError(error, stackTrace);
      });
    }

    final friendsRepository = ref.watch(friendsRepositoryProvider);
    final storiesRepository = ref.watch(storiesRepositoryProvider);
    final authNotifier = ref.watch(authNotifierProvider);
    final isCurrentUser = authNotifier.user!.uid == user.uid;

    final result = await Future.wait([
      storiesRepository.getStoriesFromUser(user: user, page: 0),
      friendsRepository.getFollowersCount(uid: user.uid),
      friendsRepository.getFollowingCount(uid: user.uid),
      if (!isCurrentUser && authNotifier.user != null)
        friendsRepository.getFriend(uid: user.uid),
    ]);

    final storiesResult = result[0] as Result<PageEntity<StoryEntity>>;
    final followersResult = result[1] as Result<int>;
    final followingResult = result[2] as Result<int>;
    final pendingResult = (result.length > 3)
        ? (result[3] as Result<FriendEntity?>)
        : Result.success(null);

    storiesResult.when((stories) {
      FriendEntity? friendRequest = pendingResult.when(
        (value) => value,
        (_, __) => null,
      );

      if (authNotifier.user != null &&
          friendRequest != null &&
          friendRequest.state == FriendRequestState.following &&
          friendRequest.receiverUid == authNotifier.user!.uid) {
        friendRequest = friendRequest.copyWith(
          state: FriendRequestState.requested,
        );
      }

      state = AsyncData(
        ProfileState(
          status: ProfileStatus.success,
          user: user,
          isCurrentUser: isCurrentUser,
          stories: stories.content,
          friend: friendRequest,
          followers: followersResult.when((value) => value, (_, __) => 0),
          following: followingResult.when((value) => value, (_, __) => 0),
          totalPages: stories.totalPages,
          total: stories.total,
        ),
      );
    }, (error, stackTrace) => state = AsyncError(error, stackTrace));

    return state.value ?? ProfileState();
  }

  Future<void> sendRequest({required String receiverId}) async {
    final friendsRepository = ref.watch(friendsRepositoryProvider);
    final authNotifier = ref.watch(authNotifierProvider);

    if (authNotifier.user != null) {
      final result = await friendsRepository.sendRequest(
        senderId: authNotifier.user!.uid,
        receiverId: receiverId,
      );

      result.when(
        (data) => state = AsyncData(
          state.value!.copyWith(
            friend: data,
            followers: (state.value?.followers ?? 0) + 1,
          ),
        ),
        (error, stackTrace) => AsyncError(error, stackTrace),
      );
    }
  }

  Future<void> acceptRequest() async {
    final friendsRepository = ref.watch(friendsRepositoryProvider);

    if (state.value?.friend != null) {
      final result = await friendsRepository.accept(
        request: state.value!.friend!,
      );

      result.when(
        (_) => state = AsyncData(
          state.value!.copyWith(
            friend: state.value!.friend?.copyWith(
              state: FriendRequestState.friend,
            ),
            following: state.value!.following + 1,
          ),
        ),
        (_, __) {},
      );
    }
  }

  Future<void> rejectRequest() async {
    final friendsRepository = ref.watch(friendsRepositoryProvider);

    if (state.value?.friend != null) {
      final result = await friendsRepository.reject(
        request: state.value!.friend!,
      );

      result.when(
        (_) => state = AsyncData(state.value!.clearRequest()),
        (_, __) {},
      );
    }
  }

  Future<void> nextPage() async {
    final storiesRepository = ref.watch(storiesRepositoryProvider);
    final authNotifier = ref.watch(authNotifierProvider);

    if (state.value != null && !state.value!.isLast) {
      state = AsyncData(state.value!.copyWith(page: state.value!.page + 1));

      final result = await storiesRepository.getStoriesFromUser(
        user: authNotifier.user!,
        page: state.value!.page,
        total: state.value!.total,
      );

      result.when(
        (data) => state = AsyncData(
          ProfileState(stories: [...state.value!.stories, ...data.content]),
        ),
        (error, stackTrace) => AsyncError(error, stackTrace),
      );
    }
  }
}

final profileNotifierProvider = AsyncNotifierProvider.autoDispose
    .family<ProfileAsyncNotifier, ProfileState, ProfileParams>(
      (params) => ProfileAsyncNotifier(params: params),
    );
