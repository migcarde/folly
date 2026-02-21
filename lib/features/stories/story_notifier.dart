import 'dart:async';

import 'package:domain/comments/comments_repository.dart';
import 'package:domain/stories/models/story_entity.dart';
import 'package:domain/stories/stories_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/stories/models/story_state.dart';

class StoryNotifier extends AsyncNotifier<StoryState> {
  final String storyId;

  StoryNotifier({required this.storyId});

  @override
  FutureOr<StoryState> build() async {
    state = AsyncLoading();

    final storiesRepository = ref.watch(storiesRepositoryProvider);
    final result = await storiesRepository.getStory(storyId: storyId);

    result.when(
      (story) async => await _getComments(story: story),
      (e, stackTrace) => state = AsyncError(e, stackTrace),
    );

    return state.value!;
  }

  Future<void> _getComments({required StoryEntity story}) async {
    final commentsRepository = ref.watch(commentsRepositoryProvider);
    final result = await commentsRepository.getComments(
      uid: story.user.uid,
      storyId: storyId,
      page: state.value?.page ?? 0,
      total: state.value?.total,
    );

    result.when(
      (comments) {
        state = AsyncData(
          StoryState(
            story: story,
            comments: comments.content,
            page: comments.page,
            total: comments.total,
          ),
        );
      },
      (e, stackTrace) {
        // TODO: Handle this error case showing comments cannot be loaded section
      },
    );
  }

  Future<void> nextPage() async {
    if (state.value?.isLast == false && state.value != null) {
      state = AsyncValue.data(
        state.value!.copyWith(page: state.value!.page + 1),
      );
      await _getComments(story: state.value!.story);
    }
  }
}

final storyProvider = AsyncNotifierProvider.autoDispose
    .family<StoryNotifier, StoryState, String>(
      (storyId) => StoryNotifier(storyId: storyId),
    );
