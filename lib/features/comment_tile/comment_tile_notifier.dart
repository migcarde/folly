import 'dart:async';

import 'package:domain/comments/comments_repository.dart';
import 'package:domain/comments/models/comment_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/comment_tile/models/comment_tile_state.dart';

class CommentTileNotifier extends AsyncNotifier<CommentTileState> {
  final String commentId;

  CommentTileNotifier({required this.commentId});

  @override
  FutureOr<CommentTileState> build() {
    state = const AsyncData(CommentTileState());

    return const CommentTileState();
  }

  Future<void> nextPage({required String parentCommentId}) async {
    if (state.value?.isLast == false && state.value != null) {
      if (state.value!.replies.isNotEmpty) {
        state = AsyncData(state.value!.copyWith(page: state.value!.page + 1));
      }

      state = AsyncLoading();
      await _getReplies(parentCommentId: parentCommentId);
    }
  }

  Future<void> _getReplies({required String parentCommentId}) async {
    final result = await ref
        .read(commentsRepositoryProvider)
        .getReplies(
          parentCommentId: parentCommentId,
          page: state.value?.page ?? 0,
          total: state.value?.total,
        );

    result.when(
      (data) => state = AsyncData(
        CommentTileState(
          replies: [...state.value?.replies ?? [], ...data.content],
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (e, strackTrace) => state = AsyncError(e, strackTrace),
    );
  }

  Future<void> addComment({required CommentEntity comment}) async =>
      state = AsyncData(
        state.value!.copyWith(
          replies: [comment, ...state.value!.replies],
          total: (state.value!.total ?? 0) + 1,
        ),
      );
}

final commentTileNotifierProvider = AsyncNotifierProvider.family
    .autoDispose<CommentTileNotifier, CommentTileState, String>(
      (commentId) => CommentTileNotifier(commentId: commentId),
    );
