import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/comments/comments_dialog.dart';
import 'package:folly/features/story_card/story_card_notifier.dart';
import 'package:folly/widgets/media_viewer.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StoryCard extends ConsumerWidget {
  const StoryCard({
    super.key,
    required this.storyId,
    required this.user,
    required this.userProfileUrl,
    required this.title,
    required this.mediaUrl,
    required this.challenge,
  });

  final String storyId;
  final String user;
  final String userProfileUrl;
  final String title;
  final String mediaUrl;
  final String challenge;

  static const _iconSize = 32.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = context.theme;

    final state = ref.watch(storyCardNotifierProvider(storyId));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.screenPadding,
          ),
          child: Row(
            children: [
              ProfileImage(size: 40.0, imageUrl: userProfileUrl),
              Padding(
                padding: const EdgeInsets.only(left: AppDimens.s),
                child: Text(
                  user,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Spacer(),
              Icon(PhosphorIcons.bookmarkSimple(), size: _iconSize),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimens.s),
          child: Align(
            alignment: AlignmentDirectional.center,
            child: MediaViewer.fromUrl(url: mediaUrl),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
            top: AppDimens.s,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title),
              const Spacer(),
              Text(state.value?.commentsCount.toString() ?? '0'),
              GestureDetector(
                onTap: () {
                  // TODO: Show comments bottombar
                  showModalBottomSheet(
                    context: context,
                    backgroundColor: Colors.white,
                    builder: (context) {
                      return CommentsDialog(storyId: storyId);
                    },
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: AppDimens.xs,
                    right: AppDimens.s,
                  ),
                  child: Icon(PhosphorIcons.chatCircle(), size: _iconSize),
                ),
              ),
              Text(state.value?.likesCount.toString() ?? '0'),
              GestureDetector(
                onTap: () {
                  if (state.value?.like != null) {
                    ref
                        .read(storyCardNotifierProvider(storyId).notifier)
                        .unlike();
                  } else {
                    ref
                        .read(storyCardNotifierProvider(storyId).notifier)
                        .like();
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: AppDimens.xs),
                  child: Icon(
                    PhosphorIcons.heart(
                      state.value?.like != null
                          ? PhosphorIconsStyle.fill
                          : PhosphorIconsStyle.regular,
                    ),
                    size: _iconSize,
                    color: state.value?.like != null
                        ? Colors.red
                        : null, // TODO: Check color
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: AppDimens.m,
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
          ),
          child: RichText(
            text: TextSpan(
              style: theme.textTheme.bodyMedium,

              children: [
                TextSpan(
                  text: '${context.l10n.challenge}: ',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: challenge),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
