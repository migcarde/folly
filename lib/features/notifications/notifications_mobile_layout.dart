import 'package:domain/notifications/enums/notification_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/features/notifications/notifications_notifier.dart';
import 'package:folly/features/notifications/widgets/notification_tile.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/base_divider.dart';
import 'package:go_router/go_router.dart';

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

              switch (notification.type) {
                case NotificationType.like:
                  // TODO: Handle this case.
                  throw UnimplementedError();
                case NotificationType.comment:
                  // TODO: Handle this case.
                  throw UnimplementedError();
                case NotificationType.follow:
                  context.pushNamed(
                    Paths.userProfile.name,
                    extra: ProfileParams(user: notification.senderUser),
                  );
              }
            },
            child: NotificationTile(
              user: notification.senderUser,
              date: notification.createdAt,
              type: notification.type,
              isRead: notification.isRead,
            ),
          );
        },
        separatorBuilder: (context, index) => BaseDivider(),
        itemCount: data.notifications.length,
      ),
      error: (e, err) => const SizedBox(),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
