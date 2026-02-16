import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/friends/enums/friend_type.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/features/home/widget/upload_story_options_dialog.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/profile/profile_notifier.dart';
import 'package:folly/features/profile/widgets/request_information.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/empty_widget.dart';
import 'package:folly/widgets/profile_image.dart';
import 'package:folly/features/story_card/story_card.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileMobileLayout extends ConsumerWidget {
  const ProfileMobileLayout({super.key, required this.params});

  final ProfileParams params;

  static const _profileImageSize = 100.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = ref.watch(profileNotifierProvider(params));
    final profileNotifier = ref.read(profileNotifierProvider(params).notifier);

    return state.when(
      data: (data) => SingleChildScrollView(
        padding: const EdgeInsets.only(
          top: AppDimens.screenPadding,
          bottom: 120.0,
        ),
        child: Column(
          children: [
            if (data.isCurrentUser)
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(
                    right: AppDimens.screenPadding,
                  ),
                  child: GestureDetector(
                    child: Icon(PhosphorIcons.gear()),
                    onTap: () => context.pushNamed(Paths.settings.name),
                  ),
                ),
              ),
            ProfileImage(
              imageUrl: data.user?.photoPath,
              size: _profileImageSize,
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.m),
              child: Text(
                data.user?.name ?? '',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Text(
              '@${data.user?.username}',
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
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      Paths.friends.name,
                      extra: FriendsViewModel(
                        friendType: FriendType.followers,
                        uid: data.user?.uid ?? '',
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          l10n.followers,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(data.followers.toString()),
                      ],
                    ),
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
                  GestureDetector(
                    onTap: () => context.pushNamed(
                      Paths.friends.name,
                      extra: FriendsViewModel(
                        friendType: FriendType.following,
                        uid: data.user?.uid ?? '',
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          l10n.following,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(data.following.toString()),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (!data.isCurrentUser)
              RequestInformation(
                uid: data.user?.uid ?? '',
                friendRequest: data.friend,
                onAccept: () => profileNotifier.acceptRequest(),
                onReject: () => profileNotifier.rejectRequest(),
                onSend: () async => profileNotifier.sendRequest(
                  receiverId: data.user?.uid ?? '',
                ),
              ),
            if (data.user?.biography.isNotEmpty ?? false)
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.m,
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding,
                ),
                child: ExpandableText(
                  data.user?.biography ?? '',
                  maxLines: 3,
                  expandText:
                      '\n${l10n.show_more}', // Added \n to separate it from biography
                  collapseText:
                      '\n${l10n.show_less}', // Added \n to separate it from biography
                  textAlign: TextAlign.center,
                  animation: true,
                  style: theme.textTheme.bodySmall,
                  linkColor: theme.primaryColor,
                ),
              ),
            if (data.stories.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.l),
                child: ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final story = data.stories[index];

                    return StoryCard(
                      storyId: story.id,
                      userId: data.user?.uid ?? '',
                      user: data.user?.name ?? '',
                      userProfileUrl: data.user?.photoPath ?? '',
                      title: story.title,
                      mediaUrl: story.imageUrl,
                      challenge: story.challenge,
                    );
                  },
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: AppDimens.l),
                  itemCount: data.stories.length,
                ),
              ),
            if (data.stories.isEmpty)
              Padding(
                padding: const EdgeInsets.only(
                  top: AppDimens.m,
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding,
                ),
                child: EmptyWidget(
                  title: l10n.no_stories_yet,
                  message: data.isCurrentUser
                      ? l10n.unleash_your_creativity_tap_to_upload_your_stories
                      : l10n.this_user_does_not_publish_any_story_yet,
                  buttonText: data.isCurrentUser ? l10n.publish_a_story : null,
                  onTap: () {
                    if (data.isCurrentUser) {
                      UploadStoryOptionsDialog.checkAvailability(
                        context: context,
                        isCompleted: false,
                      );
                    }
                  },
                ),
              ),
          ],
        ),
      ),
      error: (error, stackTrace) => Center(
        child: Text(l10n.sorry_we_have_problems_please_try_again_later),
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
