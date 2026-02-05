import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/core/container_decorators.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/daily_challenge/daily_challenge_provider.dart';
import 'package:folly/features/daily_challenge/models/daily_challenge_state.dart';
import 'package:folly/features/home/widget/upload_story_options_dialog.dart';
import 'package:lottie/lottie.dart';

class DailyChallengeMobileLayout extends ConsumerStatefulWidget {
  const DailyChallengeMobileLayout({super.key});

  @override
  ConsumerState<DailyChallengeMobileLayout> createState() =>
      _DailyChallengeMobileLayoutState();
}

class _DailyChallengeMobileLayoutState
    extends ConsumerState<DailyChallengeMobileLayout> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(dailyChallengeNotifierProvider.notifier).init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;
    final state = ref.watch(dailyChallengeNotifierProvider);

    switch (state.status) {
      case DailyChallengeStatus.loading:
      case DailyChallengeStatus.error:
      case DailyChallengeStatus.completed:
        return const SizedBox();
      case DailyChallengeStatus.success:
        return Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimens.cardPaddingHorizontal,
            vertical: AppDimens.cardPaddingVertical,
          ),
          decoration: ContainerDecorators.card(
            color: theme.colorScheme.primaryContainer,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Lottie.asset('assets/lotties/lemony.json', height: 80.0),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(left: AppDimens.s),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        l10n.challenge_time,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(state.challenge),
                      Padding(
                        padding: const EdgeInsets.only(top: AppDimens.m),
                        child: GestureDetector(
                          onTap: () =>
                              UploadStoryOptionsDialog.checkAvailability(
                                context: context,
                                isCompleted: state.status.isCompleted,
                              ),
                          child: Text(
                            l10n.publish_a_story,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
    }
  }
}
