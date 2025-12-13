import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentTile extends StatelessWidget {
  const CommentTile({
    super.key,
    required this.name,
    required this.photoPath,
    required this.comment,
    required this.likes,
    required this.hasUserLike,
    required this.onTapProfile,
    required this.onTapLike,
    required this.onTapReply,
    required this.isReply,
  });

  final String name;
  final String photoPath;
  final String comment;
  final int likes;
  final bool hasUserLike;
  final VoidCallback onTapProfile;
  final VoidCallback onTapLike;
  final VoidCallback onTapReply;
  final bool isReply;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onTapProfile,
              child: ProfileImage(imageUrl: photoPath),
            ),
            Column(
              children: [
                Text(
                  name,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(comment),
              ],
            ),
            Text(likes.toString()),
            GestureDetector(
              onTap: onTapLike,
              child: Icon(PhosphorIcons.heart()),
            ),
          ],
        ),
        GestureDetector(
          onTap: onTapLike,
          child: Row(
            children: [
              Icon(PhosphorIcons.chatCircle()),
              Text(
                l10n.reply_to(name),
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
