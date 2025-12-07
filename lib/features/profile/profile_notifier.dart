import 'package:domain/base/result.dart';
import 'package:domain/domain.dart';
import 'package:domain/requests/enums/friend_request_state.dart';
import 'package:domain/requests/models/friend_request_entity.dart';
import 'package:domain/requests/request_repository.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/profile/models/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier({
    required this.storiesRepository,
    required this.requestsRepository,
    required this.authNotifier,
  }) : super(const ProfileState());

  final StoriesRepository storiesRepository;
  final RequestRepository requestsRepository;
  final AuthNotifier authNotifier;

  Future<void> init({
    required UserEntity user,
    required bool isCurrentUser,
  }) async {
    final result = await Future.wait([
      storiesRepository.getStoriesFromUser(user: user),
      if (!isCurrentUser && authNotifier.user != null)
        requestsRepository.getRequestStatus(
          user: authNotifier.user!,
          receiverId: user.uid,
        ),
    ]);

    final storiesResult = result[0] as Result<List<StoryEntity>>;
    final pendingResult = (result.length > 1)
        ? (result[1] as Result<FriendRequestEntity?>)
        : Result.success(null);

    storiesResult.when((stories) {
      final friendRequest = pendingResult.when((value) => value, (_) => null);

      state = state.copyWith(
        status: ProfileStatus.success,
        stories: stories,
        friendRequest: friendRequest,
      );
    }, (_) => state = state.copyWith(status: ProfileStatus.error));
  }

  Future<void> sendRequest({required String receiverId}) async {
    if (authNotifier.user != null) {
      final result = await requestsRepository.sendRequest(
        senderId: authNotifier.user!.uid,
        receiverId: receiverId,
      );

      result.when(
        (data) => state = state.copyWith(
          friendRequest: FriendRequestEntity(state: FriendRequestState.pending),
        ),
        (_) => state = state.copyWith(status: ProfileStatus.error),
      );
    }
  }

  Future<void> acceptRequest() async {
    if (state.friendRequest?.request != null) {
      final result = await requestsRepository.acceptRequest(
        request: state.friendRequest!.request!,
      );

      result.when(
        (_) => state = state.copyWith(
          friendRequest: state.friendRequest?.copyWith(
            state: FriendRequestState.friend,
          ),
        ),
        (_) {},
      );
    }
  }

  Future<void> rejectRequest() async {
    if (state.friendRequest?.request != null) {
      final result = await requestsRepository.rejectRequest(
        request: state.friendRequest!.request!,
      );

      result.when((_) => state = state.clearRequest(), (_) {});
    }
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      (ref) => ProfileNotifier(
        storiesRepository: ref.watch(storiesRepositoryProvider),
        requestsRepository: ref.watch(requestRepositoryProvider),
        authNotifier: ref.watch(authNotifierProvider),
      ),
    );
