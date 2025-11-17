import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/home/models/home_notifier_state.dart';

class HomeNotifier extends StateNotifier<HomeNotifierState> {
  HomeNotifier({required this.authNotifier, required this.storiesRepository})
    : super(const HomeNotifierState());

  final AuthNotifier authNotifier;
  final StoriesRepository storiesRepository;

  Future<void> init() async {
    state = state.copyWith(status: HomeNotifierStatus.loading);
    if (authNotifier.user?.uid.isNotEmpty == true) {
      final result = await storiesRepository.getStories(
        uids: [authNotifier.user!.uid],
      );

      result.when(
        (stories) => state = state.copyWith(
          status: HomeNotifierStatus.success,
          stories: stories,
        ),
        (_) => state = state.copyWith(status: HomeNotifierStatus.error),
      );
    }
  }
}

final homeNotifierProvider =
    StateNotifierProvider.autoDispose<HomeNotifier, HomeNotifierState>(
      (ref) => HomeNotifier(
        authNotifier: ref.watch(authNotifierProvider),
        storiesRepository: ref.watch(storiesRepositoryProvider),
      ),
    );
