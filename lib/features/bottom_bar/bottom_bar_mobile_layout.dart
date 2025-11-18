import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/bottom_bar/bottom_bar_notifier.dart';
import 'package:folly/features/bottom_bar/models/bottom_bar_state.dart';
import 'package:folly/features/daily_challenge/daily_challenge_provider.dart';
import 'package:folly/features/home/widget/upload_story_options_dialog.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BottomBarMobileLayout extends ConsumerWidget {
  const BottomBarMobileLayout({super.key});

  static const _blur = 6.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(bottomBarNotifierProvider);
    final user = ref.watch(authNotifierProvider).user;
    final theme = context.theme;

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: _blur, sigmaY: _blur),
        child: Container(
          color: theme.primaryColor.withAlpha(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: BottomBarItem.values.map((item) {
              final isSelected = state.selectedItem == item;

              if (item.isProfile) {
                return Container(
                  width: 24.0,
                  height: 24.0,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(
                      AppDimens.circularRadius,
                    ),
                  ),
                  child: ClipOval(
                    child: user?.photoPath != null && user!.photoPath.isNotEmpty
                        ? Image.network(
                            user.photoPath,
                            width: 24.0,
                            height: 24.0,
                            fit: BoxFit.cover,
                          )
                        : Icon(
                            Icons.person,
                            size: 24.0 * 0.6,
                            color: theme.primaryColor,
                          ),
                  ),
                );
              }

              return IconButton(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  final isCompleted = ref
                      .read(dailyChallengeNotifierProvider)
                      .status
                      .isCompleted;
                  if (item.isUpdateStory) {
                    UploadStoryOptionsDialog.checkAvailability(
                      context: context,
                      isCompleted: isCompleted,
                    );
                  } else {
                    ref
                        .read(bottomBarNotifierProvider.notifier)
                        .selectItem(item);
                  }
                },
                icon: Icon(switch (item) {
                  BottomBarItem.home =>
                    isSelected
                        ? PhosphorIcons.house(PhosphorIconsStyle.fill)
                        : PhosphorIcons.house(),
                  BottomBarItem.search =>
                    isSelected
                        ? PhosphorIcons.magnifyingGlass(PhosphorIconsStyle.fill)
                        : PhosphorIcons.magnifyingGlass(),
                  BottomBarItem.updateStory => PhosphorIcons.plusCircle(),
                  BottomBarItem.notifications =>
                    isSelected
                        ? PhosphorIcons.bell(PhosphorIconsStyle.fill)
                        : PhosphorIcons.bell(),
                  BottomBarItem.profile =>
                    isSelected
                        ? PhosphorIcons.person(PhosphorIconsStyle.fill)
                        : PhosphorIcons.person(),
                }, color: theme.iconTheme.color),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
