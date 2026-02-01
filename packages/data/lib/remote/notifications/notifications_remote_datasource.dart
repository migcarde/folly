import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/notifications/models/notification_remote_entity.dart';

abstract class NotificationsRemoteDatasource {
  Future<void> createNotification({
    required NotificationRemoteEntity notification,
  });
  Future<void> deleteNotification({required String id});
  Future<NotificationRemoteEntity> updateNotification({
    required NotificationRemoteEntity notification,
  });
  Future<PageRemoteEntity<NotificationRemoteEntity>> getNotifications({
    required String receiverUserId,
    required int page,
    int size = 10,
    int? total,
  });
}
