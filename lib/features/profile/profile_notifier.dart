import 'package:domain/base/result.dart';
import 'package:domain/domain.dart';
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
        requestsRepository.isPending(
          user: user,
          receiverId: authNotifier.user!.uid,
        ),
    ]);

    final storiesResult = result[0] as Result<List<StoryEntity>>;
    final pendingResult = (result.length > 1)
        ? (result[1] as Result<bool>)
        : Result.success(false);

    storiesResult.when((stories) {
      final isPending = pendingResult.when((value) => value, (_) => false);

      state = state.copyWith(
        status: ProfileStatus.success,
        stories: stories,
        requestStatus: isPending ? RequestStatus.pending : RequestStatus.none,
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
        (data) => state = state.copyWith(requestStatus: RequestStatus.pending),
        (_) => state = state.copyWith(status: ProfileStatus.error),
      );
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
