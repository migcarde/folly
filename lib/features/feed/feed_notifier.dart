import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/feed/models/feed_notifier_state.dart';

class FeedNotifier extends StateNotifier<FeedNotifierState> {
  FeedNotifier({required this.authNotifier, required this.storiesRepository})
    : super(const FeedNotifierState());

  final AuthNotifier authNotifier;
  final StoriesRepository storiesRepository;

  Future<void> init() async {
    state = state.copyWith(status: FeedNotifierStatus.loading);
    if (authNotifier.user?.uid.isNotEmpty == true) {
      await _getStories();
    }
  }

  Future<void> nextPage() async {
    if (!state.isLast) {
      state = state.copyWith(page: state.page + 1);
      await _getStories();
    }
  }

  Future<void> _getStories() async {
    final result = await storiesRepository.getStories(
      uids: [authNotifier.user!.uid],
      page: state.page,
    );

    result.when(
      (stories) => state = state.copyWith(
        status: FeedNotifierStatus.success,
        stories: [...state.stories, ...stories.content],
        page: stories.page,
        totalPages: stories.totalPages,
        total: stories.total,
      ),
      (_) => state = state.copyWith(status: FeedNotifierStatus.error),
    );
  }
}

final feedNotifierProvider =
    StateNotifierProvider.autoDispose<FeedNotifier, FeedNotifierState>(
      (ref) => FeedNotifier(
        authNotifier: ref.watch(authNotifierProvider),
        storiesRepository: ref.watch(storiesRepositoryProvider),
      ),
    );
