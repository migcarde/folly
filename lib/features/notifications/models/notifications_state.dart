import 'package:domain/notifications/models/notification_entity.dart';
import 'package:equatable/equatable.dart';

class NotificationsState extends Equatable {
  final List<NotificationEntity> notifications;
  final int page;
  final int totalPages;
  final int? total;

  const NotificationsState({
    this.notifications = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total = 0,
  });

  @override
  List<Object?> get props => [notifications, page, totalPages, total];

  NotificationsState copyWith({
    List<NotificationEntity>? notifications,
    int? page,
    int? totalPages,
    int? total,
  }) => NotificationsState(
    notifications: notifications ?? this.notifications,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) == totalPages;

  NotificationsState replaceNotification({
    required NotificationEntity notification,
  }) {
    final updatedNotifications = notifications.map((n) {
      if (n.id == notification.id) {
        return notification;
      }
      return n;
    }).toList();

    return copyWith(notifications: updatedNotifications);
  }
}
