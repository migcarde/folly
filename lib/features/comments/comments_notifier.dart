import 'dart:async';

import 'package:domain/comments/models/comment_entity.dart';
import 'package:domain/domain.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/comments/models/comments_state.dart';

class CommentsNotifier extends AsyncNotifier<CommentsState> {
  final String storyId;

  CommentsNotifier({required this.storyId});

  @override
  FutureOr<CommentsState> build() async {
    state = const AsyncLoading();

    final user = ref.read(authNotifierProvider).user;

    final result = await ref
        .read(commentsRepositoryProvider)
        .getComments(
          storyId: storyId,
          uid: user?.uid ?? '',
          page: state.value?.page ?? 0,
          total: state.value?.total,
        );

    result.when(
      (data) => state = AsyncData(
        CommentsState(
          comments: data.content,
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (e, stackTrace) => state = AsyncError(e, stackTrace),
    );

    return state.value!;
  }

  Future<void> nextPage() async {
    if (state.value?.isLast == false && state.value != null) {
      state = AsyncValue.data(
        state.value!.copyWith(page: state.value!.page + 1),
      );
      await _getComments();
    }
  }

  Future<void> _getComments() async {
    final result = await ref
        .read(commentsRepositoryProvider)
        .getComments(
          storyId: storyId,
          uid: ref.read(authNotifierProvider).user?.uid ?? '',
          page: state.value?.page ?? 0,
          total: state.value?.total ?? 0,
        );

    result.when(
      (data) => state = AsyncData(
        CommentsState(
          comments: [...state.value?.comments ?? [], ...data.content],
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (e, strackTrace) => state = AsyncError(e, strackTrace),
    );
  }

  Future<void> createComment({required String text}) async {
    final user = ref.read(authNotifierProvider).user;

    if (user != null && state.value != null) {
      final comment = CommentEntity(
        id: '',
        storyId: storyId,
        user: user,
        text: text,
        parentCommentId: state.value?.commentToReply?.id,
        replies: [],
      );

      final result = await ref
          .read(commentsRepositoryProvider)
          .createComment(comment: comment);

      result.when(
        (data) => state = AsyncData(
          state.value!.copyWith(
            comments: [comment, ...state.value?.comments ?? []],
          ),
        ),
        (failure, __) => state = AsyncData(
          state.value!.copyWith(
            error: CommentsErrorMessages.createCommentError,
          ),
        ),
      );
    }
  }

  Future<void> setCommentToReply(CommentEntity? comment) async {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.copyWith(commentToReply: comment));
    }
  }

  Future<void> clearCommentToReply() async {
    if (state.value != null) {
      state = AsyncValue.data(state.value!.clearCommentToReply());
    }
  }
}

final commentsNotifierProvider = AsyncNotifierProvider.family
    .autoDispose<CommentsNotifier, CommentsState, String>(
      (storyId) => CommentsNotifier(storyId: storyId),
    );
