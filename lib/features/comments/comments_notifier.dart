import 'dart:async';

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
          total: state.value?.total ?? 0,
        );

    result.when(
      (data) => state = AsyncData(
        CommentsState(
          status: data.content.isEmpty
              ? CommentsStatus.empty
              : CommentsStatus.data,
          comments: data.content,
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (e) => state = AsyncData(CommentsState(status: CommentsStatus.error)),
    );

    return state.value!;
  }
}

final commentsNotifierProvider =
    AsyncNotifierProvider.family<CommentsNotifier, CommentsState, String>(
      (storyId) => CommentsNotifier(storyId: storyId),
    );
