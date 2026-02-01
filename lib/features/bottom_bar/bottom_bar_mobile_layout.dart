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
import 'package:folly/features/notifications/notifications_notifier.dart';
import 'package:folly/widgets/profile_image.dart';
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
          padding: const EdgeInsets.only(bottom: AppDimens.m),
          color: theme.primaryColor.withAlpha(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: BottomBarItem.values.map((item) {
              final isSelected = state.selectedItem == item;

              if (item.isProfile) {
                return GestureDetector(
                  onTap: () => ref
                      .read(bottomBarNotifierProvider.notifier)
                      .selectItem(item),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.colorScheme.outlineVariant,
                      border: BoxBorder.all(
                        color: isSelected
                            ? theme.primaryColor
                            : Colors.transparent,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(
                        AppDimens.circularRadius,
                      ),
                    ),
                    child: ProfileImage(imageUrl: user?.photoPath),
                  ),
                );
              } else if (item.isNotifications) {
                final notificationsState = ref.watch(
                  notificationsNotifierProvider,
                );

                final unreadNotifications =
                    notificationsState.value?.notifications
                        .where((notification) => !notification.isRead)
                        .length ??
                    0;

                return IconButton(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  onPressed: () {
                    ref
                        .read(bottomBarNotifierProvider.notifier)
                        .selectItem(item);
                  },
                  icon: Stack(
                    children: [
                      Icon(
                        isSelected
                            ? PhosphorIcons.bell(PhosphorIconsStyle.fill)
                            : PhosphorIcons.bell(),
                        color: theme.iconTheme.color,
                      ),
                      if (unreadNotifications > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 2.0,
                            ),
                            decoration: BoxDecoration(
                              color: theme.primaryColor,
                              borderRadius: BorderRadius.circular(
                                AppDimens.circularRadius,
                              ),
                            ),
                            child: Text(
                              unreadNotifications > 99
                                  ? '99+'
                                  : unreadNotifications.toString(),
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: Colors.white,
                                fontSize: 10.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
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
