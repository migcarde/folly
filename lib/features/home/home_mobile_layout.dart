import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/daily_challenge/daily_challenge_mobile_layout.dart';
import 'package:folly/features/home/home_notifier.dart';
import 'package:folly/features/home/models/home_notifier_state.dart';
import 'package:folly/widgets/media_viewer.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeMobileLayout extends ConsumerStatefulWidget {
  const HomeMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _HomeMobileLayoutState();
}

class _HomeMobileLayoutState extends ConsumerState<HomeMobileLayout> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeNotifierProvider.notifier).init();
    });
  }

  static const _iconSize = 32.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final state = ref.watch(homeNotifierProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.only(bottom: 80.0),
      child: Column(
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
            HomeNotifierStatus.loading => const CircularProgressIndicator(),
            HomeNotifierStatus.success => ListView.separated(
              itemCount: state.stories.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppDimens.l),
              itemBuilder: (context, index) {
                final story = state.stories[index];
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
                          Container(
                            height: 40.0,
                            width: 40.0,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: theme
                                  .colorScheme
                                  .outlineVariant, // TODO: Add profile image
                            ),
                            child: Icon(
                              PhosphorIcons.user(PhosphorIconsStyle.fill),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: AppDimens.s),
                            child: Text(
                              story.user.name,
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
                        child: MediaViewer.fromUrl(url: story.imageUrl),
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
                          Text(story.title),
                          const Spacer(),
                          // TODO: Replace with comments count and functionality
                          Text('0'),
                          Padding(
                            padding: const EdgeInsets.only(
                              left: AppDimens.xs,
                              right: AppDimens.s,
                            ),
                            child: Icon(
                              PhosphorIcons.chatCircle(),
                              size: _iconSize,
                            ),
                          ),
                          Text(story.likes.toString()),
                          GestureDetector(
                            onTap: () {
                              // TODO: Add like functionality
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: AppDimens.xs,
                              ),
                              child: Icon(
                                PhosphorIcons.heart(),
                                size: _iconSize,
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
                            TextSpan(text: story.challenge),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
            HomeNotifierStatus.error => const Text('Error loading stories'),
          },
        ],
      ),
    );
  }
}
