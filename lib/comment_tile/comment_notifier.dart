import 'dart:async';

import 'package:domain/base/result.dart';
import 'package:domain/likes/likes_repository.dart';
import 'package:domain/likes/models/like_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/comment_tile/models/comment_state.dart';
import 'package:folly/features/auth_notifier.dart';

class CommentNotifier extends AsyncNotifier<CommentState> {
  final String commentId;

  CommentNotifier({required this.commentId});

  @override
  FutureOr<CommentState> build() async {
    CommentState result = CommentState();

    final user = ref.read(authNotifierProvider).user;
    final results = await Future.wait([
      ref
          .read(likesRepositoryProvider)
          .getCommentLikesCount(commentId: commentId),
      if (user != null)
        ref
            .read(likesRepositoryProvider)
            .getCommentLike(commentId: commentId, uid: user.uid),
    ]);

    final likesCountResult = results[0] as Result<int>;
    final likeResult = results.length > 1
        ? results[1] as Result<LikeEntity?>
        : null;

    result = result.copyWith(
      likesCount: likesCountResult.when((data) => data, (_, __) => 0),
    );

    likeResult?.ifSuccess((data) {
      result = result.copyWith(like: data);
    });

    return result;
  }

  Future<void> like() async {
    final user = ref.read(authNotifierProvider).user;
    if (user != null) {
      final result = await ref
          .read(likesRepositoryProvider)
          .likeComment(commentId: commentId, uid: user.uid);

      result.ifSuccess((data) {
        state = AsyncData(
          state.value!.copyWith(
            like: data,
            likesCount: state.value!.likesCount + 1,
          ),
        );
      });
    }
  }

  Future<void> unlike() async {
    final user = ref.read(authNotifierProvider).user;
    if (user != null && state.value?.like != null) {
      final result = await ref
          .read(likesRepositoryProvider)
          .unlikeComment(likeId: state.value!.like!.id);

      result.ifSuccess((_) => state = AsyncData(state.value!.removeLike()));
    }
  }
}

final commentNotifierProvider =
    AsyncNotifierProvider.family<CommentNotifier, CommentState, String>(
      (commentId) => CommentNotifier(commentId: commentId),
    );
