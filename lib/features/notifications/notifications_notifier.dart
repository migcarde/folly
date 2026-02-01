import 'dart:async';

import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/notifications/notifications_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/notifications/models/notifications_state.dart';

class NotificationsNotifier extends AsyncNotifier<NotificationsState> {
  @override
  FutureOr<NotificationsState> build() async {
    final user = ref.read(authNotifierProvider).user;
    final notifications = await ref
        .read(notificationsRepositoryProvider)
        .getNotifications(receiverUserId: user?.uid ?? '', page: 0, size: 20);

    notifications.when(
      (data) => state = AsyncData(
        NotificationsState(
          notifications: data.content,
          page: data.page,
          totalPages: data.totalPages,
          total: data.total,
        ),
      ),
      (e, stackTrace) => state = AsyncError(e, stackTrace),
    );

    return state.value ?? NotificationsState();
  }

  Future<void> markAsRead({required NotificationEntity notification}) async {
    final updatedNotification = notification.copyWith(isRead: true);
    final result = await ref
        .read(notificationsRepositoryProvider)
        .updateNotification(notification: updatedNotification);

    result.when(
      (data) => state = AsyncData(
        state.value!.replaceNotification(notification: data),
      ),
      (e, stackTrace) {},
    );
  }
}

final notificationsNotifierProvider =
    AsyncNotifierProvider.autoDispose<
      NotificationsNotifier,
      NotificationsState
    >(() => NotificationsNotifier());
