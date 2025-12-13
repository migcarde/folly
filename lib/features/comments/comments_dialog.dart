import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/features/comments/comments_notifier.dart';
import 'package:folly/features/comments/widgets/comment_tile.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';

class CommentsDialog extends ConsumerStatefulWidget {
  const CommentsDialog({super.key, required this.storyId});

  final String storyId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CommentsDialogState();
}

class _CommentsDialogState extends ConsumerState<CommentsDialog> {
  final _commentTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(commentsNotifierProvider(widget.storyId));

    return state.when(
      data: (data) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListView.separated(
            itemBuilder: (context, index) {
              if (index == data.comments.length && !data.isLast) {
                return const Center(child: CircularProgressIndicator());
              }

              final comment = data.comments[index];

              return CommentTile(
                name: comment.user.name,
                photoPath: comment.user.photoPath,
                comment: comment.text,
                likes: comment.likes,
                isReply: comment.parentCommentId != null,
                hasUserLike: comment.like != null,
                onTapProfile: () =>
                    context.push(Paths.userProfile.route, extra: comment.user),
                onTapLike: () {
                  // TODO: Create like comment call
                },
                onTapReply: () {
                  // TODO: Update comment textfield to reference this comment and update textfield to add reply indicator
                },
              );
            },
            separatorBuilder: (context, index) =>
                const SizedBox(height: AppDimens.m),
            itemCount: data.comments.length,
          ),
        ],
      ),
      error: (e, strackTrace) => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
