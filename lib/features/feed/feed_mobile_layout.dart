import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/bottom_bar/bottom_bar_notifier.dart';
import 'package:folly/features/bottom_bar/models/bottom_bar_state.dart';
import 'package:folly/features/daily_challenge/daily_challenge_mobile_layout.dart';
import 'package:folly/features/feed/feed_notifier.dart';
import 'package:folly/features/feed/models/feed_notifier_state.dart';
import 'package:folly/features/story_card/story_card.dart';
import 'package:folly/widgets/empty_widget.dart';

class FeedMobileLayout extends ConsumerStatefulWidget {
  const FeedMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _FeedMobileLayoutState();
}

class _FeedMobileLayoutState extends ConsumerState<FeedMobileLayout> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (ref.read(feedNotifierProvider).status == FeedNotifierStatus.loading) {
        ref.read(feedNotifierProvider.notifier).init();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(feedNotifierProvider);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
            top: AppDimens.screenPadding,
            bottom: AppDimens.l,
          ),
          child: DailyChallengeMobileLayout(),
        ),
        switch (state.status) {
          FeedNotifierStatus.loading => const CircularProgressIndicator(),
          FeedNotifierStatus.success => Expanded(
            child: ListView.separated(
              itemCount: state.stories.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(bottom: AppDimens.xl),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimens.l),
              itemBuilder: (context, index) {
                if (index == state.stories.length && !state.isLast) {
                  return const Center(child: CircularProgressIndicator());
                }

                final story = state.stories[index];

                return StoryCard(
                  userId: story.user.uid,
                  storyId: story.id,
                  user: story.user.name,
                  userProfileUrl: story.user.photoPath,
                  title: story.title,
                  mediaUrl: story.imageUrl,
                  challenge: story.challenge,
                );
              },
            ),
          ),
          FeedNotifierStatus.error => Text(
            l10n.sorry_we_have_problems_please_try_again_later,
          ),
          FeedNotifierStatus.empty => Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: AppDimens.screenPadding,
                  right: AppDimens.screenPadding,
                  bottom: AppDimens.xl,
                ),
                child: EmptyWidget(
                  title: l10n.no_stories_yet,
                  message: l10n
                      .tap_to_search_friends_and_start_sharing_your_stories_toguether,
                  buttonText: l10n.search,
                  onTap: () => ref
                      .read(bottomBarNotifierProvider.notifier)
                      .selectItem(BottomBarItem.search),
                ),
              ),
            ),
          ),
        },
      ],
    );
  }
}
