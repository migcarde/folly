import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/widgets/media_viewer.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class StoryCard extends StatelessWidget {
  const StoryCard({
    super.key,
    required this.user,
    required this.userProfileUrl,
    required this.title,
    required this.mediaUrl,
    required this.likes,
    required this.challenge,
  });

  final String user;
  final String userProfileUrl;
  final String title;
  final String mediaUrl;
  final int likes;
  final String challenge;

  static const _iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

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
              ProfileImage(
                size: 40.0,
                imageUrl: userProfileUrl,
              ), // TODO: add profile image
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
              // TODO: Replace with comments count and functionality
              Text('0'),
              Padding(
                padding: const EdgeInsets.only(
                  left: AppDimens.xs,
                  right: AppDimens.s,
                ),
                child: Icon(PhosphorIcons.chatCircle(), size: _iconSize),
              ),
              Text(likes.toString()),
              GestureDetector(
                onTap: () {
                  // TODO: Add like functionality
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: AppDimens.xs),
                  child: Icon(PhosphorIcons.heart(), size: _iconSize),
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
