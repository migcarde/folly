import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/comment_tile/comment_notifier.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentTile extends ConsumerWidget {
  const CommentTile({
    super.key,
    required this.commentId,
    required this.name,
    required this.photoPath,
    required this.comment,
    required this.onTapProfile,
    this.onTapReply,
  });

  final String commentId;
  final String name;
  final String photoPath;
  final String comment;
  final VoidCallback onTapProfile;
  final VoidCallback? onTapReply;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;
    final l10n = context.l10n;
    final state = ref.watch(commentNotifierProvider(commentId));

    return Column(
      children: [
        Row(
          children: [
            GestureDetector(
              onTap: onTapProfile,
              child: ProfileImage(imageUrl: photoPath, size: AppDimens.l),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: AppDimens.s),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TODO: Add read more when text has more than 5 lines
                    Text(comment),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppDimens.s),
              child: Text(state.value?.likesCount.toString() ?? '0'),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () => state.value?.like == null
                    ? ref
                          .read(commentNotifierProvider(commentId).notifier)
                          .like()
                    : ref
                          .read(commentNotifierProvider(commentId).notifier)
                          .unlike(),
                child: Icon(
                  PhosphorIcons.heart(
                    state.value?.like == null
                        ? PhosphorIconsStyle.regular
                        : PhosphorIconsStyle.fill,
                  ),
                  color: state.value?.like == null
                      ? null
                      : theme.colorScheme.error,
                ),
              ),
            ),
          ],
        ),
        if (onTapReply != null)
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.l, top: AppDimens.s),
            child: GestureDetector(
              onTap: onTapReply,
              child: Row(
                children: [
                  Icon(PhosphorIcons.chatCircle()),
                  Padding(
                    padding: const EdgeInsets.only(left: AppDimens.s),
                    child: Text(
                      l10n.reply_to(name),
                      style: theme.textTheme.bodyMedium?.copyWith(
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
