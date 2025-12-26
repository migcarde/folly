import 'package:domain/comments/models/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/comment_tile/comment_row.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/comment_tile/comment_tile_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({
    super.key,
    required this.comment,
    required this.onTapReply,
  });

  final CommentEntity comment;
  final VoidCallback onTapReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(commentTileNotifierProvider(comment.id));

    return Column(
      children: [
        CommentRow(
          commentId: comment.id,
          name: comment.user.username,
          photoPath: comment.user.photoPath,
          comment: comment.text,
          onTapProfile: () =>
              context.push(Paths.userProfile.route, extra: comment.user),
          onTapReply: onTapReply,
        ),
        if (state.value?.replies.isNotEmpty == true)
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.m, left: AppDimens.l),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final reply = state.value!.replies[index];

                return CommentRow(
                  commentId: state.value!.replies[index].id,
                  name: reply.user.username,
                  photoPath: reply.user.photoPath,
                  comment: reply.text,
                  onTapProfile: () =>
                      context.push(Paths.userProfile.route, extra: reply.user),
                );
              },
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimens.s),
              itemCount: state.value!.replies.length,
            ),
          ),
        if (state.value?.isLast == false && comment.repliesCount > 0)
          GestureDetector(
            onTap: () => ref
                .read(commentTileNotifierProvider(comment.id).notifier)
                .nextPage(parentCommentId: comment.id),
            child: Padding(
              padding: const EdgeInsets.only(top: AppDimens.s),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (state.isLoading)
                    SizedBox(
                      width: AppDimens.m,
                      height: AppDimens.m,
                      child: CircularProgressIndicator(
                        color: context.theme.colorScheme.secondary,
                      ),
                    )
                  else
                    Icon(
                      PhosphorIcons.caretDown(PhosphorIconsStyle.bold),
                      color: context.theme.colorScheme.secondary,
                      size: AppDimens.m,
                    ),
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimens.xs),
                    child: Text(
                      '${comment.repliesCount - (state.value?.replies.length ?? 0)} ${l10n.more_replies.toLowerCase()}',
                      style: context.theme.textTheme.bodyMedium?.copyWith(
                        color: context.theme.colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
