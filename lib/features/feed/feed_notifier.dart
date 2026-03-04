import 'package:domain/domain.dart';
import 'package:domain/feed/feed_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/feed/models/feed_notifier_state.dart';

class FeedNotifier extends StateNotifier<FeedNotifierState> {
  FeedNotifier({
    required this.authNotifier,
    required this.storiesRepository,
    required this.feedRepository,
  }) : super(const FeedNotifierState());

  final AuthNotifier authNotifier;
  final StoriesRepository storiesRepository;
  final FeedRepository feedRepository;

  Future<void> init() async {
    state = state.copyWith(status: FeedNotifierStatus.loading, stories: []);
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
    final result = await feedRepository.getFeed(
      userId: authNotifier.user!.uid,
      page: state.page,
    );

    result.when((data) {
      final stories = [...state.feed, ...data.content];

      state = state.copyWith(
        status: stories.isEmpty
            ? FeedNotifierStatus.empty
            : FeedNotifierStatus.success,
        stories: stories,
        page: data.page,
        totalPages: data.totalPages,
        total: data.total,
      );
    }, (_, __) => state = state.copyWith(status: FeedNotifierStatus.error));
  }
}

final feedNotifierProvider =
    StateNotifierProvider<FeedNotifier, FeedNotifierState>(
      (ref) => FeedNotifier(
        authNotifier: ref.watch(authNotifierProvider),
        storiesRepository: ref.watch(storiesRepositoryProvider),
        feedRepository: ref.watch(feedRepositoryProvider),
      ),
    );
