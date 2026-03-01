import 'dart:async';

import 'package:domain/base/result.dart';
import 'package:domain/domain.dart';
import 'package:domain/likes/models/like_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/story_card/models/story_card_state.dart';

class StoryCardNotifier extends AsyncNotifier<StoryCardState> {
  final String storyId;

  StoryCardNotifier({required this.storyId});

  @override
  FutureOr<StoryCardState> build() async {
    StoryCardState result = StoryCardState();
    final user = ref.read(authNotifierProvider).user;
    final results = await Future.wait([
      ref.read(likesRepositoryProvider).getStoryLikesCount(storyId: storyId),
      ref.read(commentsRepositoryProvider).getCommentsCount(storyId: storyId),
      if (user != null)
        ref
            .read(likesRepositoryProvider)
            .getStoryLike(storyId: storyId, uid: user.uid),
    ]);
    final likesCountResult = results[0] as Result<int>;
    final commentsCountResult = results[1] as Result<int>;

    result = result.copyWith(
      likesCount: likesCountResult.when((data) => data, (_, __) => 0),
      commentsCount: commentsCountResult.when((data) => data, (_, __) => 0),
    );

    if (results.length > 2) {
      final likeResult = results[2] as Result<LikeEntity?>;

      likeResult.ifSuccess((data) {
        result = result.copyWith(like: data);
      });
    }
    state = AsyncData(result);

    return result;
  }

  Future<void> like({required String receiverUserId}) async {
    final user = ref.read(authNotifierProvider).user;

    if (user != null) {
      final result = await ref
          .read(likesRepositoryProvider)
          .likeStory(
            storyId: storyId,
            uid: user.uid,
            receiverUserId: receiverUserId,
          );

      result.ifSuccess((data) {
        if (state.value != null) {
          state = AsyncData(
            state.value!.copyWith(
              like: data,
              likesCount: state.value!.likesCount + 1,
            ),
          );
        }
      });
    }
  }

  Future<void> unlike() async {
    final user = ref.read(authNotifierProvider).user;
    if (user != null && state.value?.like != null) {
      final result = await ref
          .read(likesRepositoryProvider)
          .unlikeStory(likeId: state.value!.like!.id);

      result.ifSuccess((_) => state = AsyncData(state.value!.removeLike()));
    }
  }

  Future<void> addCommentCount() async {
    if (state.value != null) {
      state = AsyncData(
        state.value!.copyWith(commentsCount: state.value!.commentsCount + 1),
      );
    }
  }
}

final storyCardNotifierProvider = AsyncNotifierProvider.autoDispose
    .family<StoryCardNotifier, StoryCardState, String>(
      (storyId) => StoryCardNotifier(storyId: storyId),
    );
