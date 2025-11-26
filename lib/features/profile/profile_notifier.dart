import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/profile/models/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier({required this.storiesRepository})
    : super(const ProfileState());

  final StoriesRepository storiesRepository;

  Future<void> init({required UserEntity user}) async {
    final storiesResult = await storiesRepository.getStoriesFromUser(
      user: user,
    );

    storiesResult.when(
      (stories) => state = state.copyWith(
        status: ProfileStatus.success,
        stories: stories,
      ),
      (_) => state = state.copyWith(status: ProfileStatus.error),
    );
  }
}

final profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>(
      (ref) => ProfileNotifier(
        storiesRepository: ref.watch(storiesRepositoryProvider),
      ),
    );
