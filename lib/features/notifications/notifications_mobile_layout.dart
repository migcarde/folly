import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/features/notifications/notifications_notifier.dart';
import 'package:folly/features/notifications/widgets/notification_tile.dart';

class NotificationsMobileLayout extends ConsumerWidget {
  const NotificationsMobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationsNotifierProvider);

    return state.when(
      data: (data) => ListView.separated(
        padding: const EdgeInsets.only(
          top: AppDimens.screenPadding,
          bottom: AppDimens.xl,
        ),
        itemBuilder: (context, index) {
          final notification = data.notifications[index];

          return GestureDetector(
            onTap: () {
              if (!notification.isRead) {
                ref
                    .read(notificationsNotifierProvider.notifier)
                    .markAsRead(notification: notification);
              }
            },
            child: NotificationTile(
              user: notification.user,
              date: notification.createdAt,
              type: notification.type,
              isRead: notification.isRead,
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.notifications.length,
      ),
      error: (e, err) => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
