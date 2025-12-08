import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/profile/models/profile_state.dart';
import 'package:folly/features/profile/profile_notifier.dart';
import 'package:folly/features/profile/widgets/request_information.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:folly/widgets/story_card.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileMobileLayout extends ConsumerStatefulWidget {
  const ProfileMobileLayout({
    super.key,
    required this.user,
    this.isCurrentUser = false,
  });

  final UserEntity user;
  final bool isCurrentUser;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProfileMobileLayoutState();
}

class _ProfileMobileLayoutState extends ConsumerState<ProfileMobileLayout> {
  static const _profileImageSize = 100.0;

  @override
  void initState() {
    super.initState();

    ref
        .read(profileNotifierProvider.notifier)
        .init(user: widget.user, isCurrentUser: widget.isCurrentUser);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = ref.watch(profileNotifierProvider);

    switch (state.status) {
      case ProfileStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case ProfileStatus.success:
        return SingleChildScrollView(
          padding: const EdgeInsets.only(
            top: AppDimens.screenPadding,
            bottom: 120.0,
          ),
          child: Column(
            children: [
              if (widget.isCurrentUser)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      right: AppDimens.screenPadding,
                    ),
                    child: GestureDetector(
                      child: Icon(PhosphorIcons.gear()),
                      onTap: () => context.push(Paths.settings.route),
                    ),
                  ),
                ),
              ProfileImage(
                imageUrl: widget.user.photoPath,
                size: _profileImageSize,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: Text(
                  widget.user.name,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '@${widget.user.username}',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.disabledColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          l10n.followers,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(state.followers.toString()),
                      ],
                    ),
                    Container(
                      height: AppDimens.l,
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimens.m,
                      ),
                      child: VerticalDivider(
                        indent: AppDimens.xs,
                        endIndent: AppDimens.xs,
                      ),
                    ),
                    Column(
                      children: [
                        Text(
                          l10n.following,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(state.following.toString()),
                      ],
                    ),
                  ],
                ),
              ),
              if (!widget.isCurrentUser)
                RequestInformation(
                  uid: widget.user.uid,
                  friendRequest: state.friend,
                ),
              // TODO: Add biography text limit and show more button
              if (widget.user.biography.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(
                    top: AppDimens.m,
                    left: AppDimens.screenPadding,
                    right: AppDimens.screenPadding,
                  ),
                  child: Text(
                    widget.user.biography,
                    textAlign: TextAlign.center,
                  ),
                ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.l),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final story = state.stories[index];

                    return StoryCard(
                      user: widget.user.name,
                      userProfileUrl: widget.user.photoPath,
                      title: story.title,
                      mediaUrl: story.imageUrl,
                      likes: story.likes,
                      challenge: story.challenge,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimens.l),
                  itemCount: state.stories.length,
                ),
              ),
            ],
          ),
        );
      case ProfileStatus.error:
        return Center(
          child: Text(l10n.sorry_we_have_problems_please_try_again_later),
        );
    }
  }
}
