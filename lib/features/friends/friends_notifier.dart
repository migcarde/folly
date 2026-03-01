import 'dart:async';

import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/friends/enums/friend_type.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/features/friends/models/friends_state.dart';

class FriendsNotifier extends AsyncNotifier<FriendsState> {
  final FriendsViewModel viewModel;

  FriendsNotifier({required this.viewModel});

  @override
  FutureOr<FriendsState> build() async {
    state = const AsyncLoading();
    final user = ref.read(authNotifierProvider).user;
    if (user != null) {
      await _getFriends();
    }

    return state.value ?? FriendsState();
  }

  Future<void> _getFriends() async {
    state = AsyncLoading();

    final result = switch (viewModel.friendType) {
      FriendType.followers =>
        await ref
            .read(friendsRepositoryProvider)
            .getFollowers(
              uid: viewModel.uid,
              page: state.value?.page ?? 0,
              total: state.value?.total,
            ),
      FriendType.following =>
        await ref
            .read(friendsRepositoryProvider)
            .getFollowing(
              uid: viewModel.uid,
              page: state.value?.page ?? 0,
              total: state.value?.total,
            ),
    };

    result.when(
      (data) => state = AsyncData(
        FriendsState(
          friends: [...state.value?.friends ?? [], ...data.content],
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (error, stackTrace) => state = AsyncError(error, stackTrace),
    );
  }

  Future<void> nextPage() async {
    if (state.value?.isLast == false && state.value != null) {
      state = AsyncData(state.value!.copyWith(page: state.value!.page + 1));
      await _getFriends();
    }
  }
}

final friendsProvider = AsyncNotifierProvider.autoDispose
    .family<FriendsNotifier, FriendsState, FriendsViewModel>(
      (viewModel) => FriendsNotifier(viewModel: viewModel),
    );
