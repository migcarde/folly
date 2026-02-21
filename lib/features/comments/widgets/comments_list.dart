import 'package:domain/comments/models/comment_entity.dart';
import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/features/comment_tile/comment_tile.dart';

class CommentsList extends StatelessWidget {
  const CommentsList({
    super.key,
    required this.scrollController,
    required this.comments,
    required this.isLast,
    required this.onTapReply,
  });

  final ScrollController scrollController;
  final List<CommentEntity> comments;
  final bool isLast;
  final Function(CommentEntity comment) onTapReply;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      controller: scrollController,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        if (index == comments.length && !isLast) {
          return const Center(child: CircularProgressIndicator());
        }

        final comment = comments[index];

        return CommentTile(
          comment: comment,
          onTapReply: () => onTapReply(comment),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: AppDimens.m),
      itemCount: comments.length,
    );
  }
}
