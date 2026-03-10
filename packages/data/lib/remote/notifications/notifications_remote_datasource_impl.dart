import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:data/remote/notifications/notifications_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class NotificationsRemoteDatasourceImpl extends NotificationsRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  static const _notificationsCollection = 'Notifications';

  @override
  Future<void> createNotification({
    required NotificationRemoteEntity notification,
    required String functionName,
  }) async {
    _supabase.client.functions.invoke(
      functionName,
      method: HttpMethod.post,
      body: notification.toRemoteNotificationJson(),
    );
    await _supabase.client
        .from(_notificationsCollection)
        .insert(notification.toJson());
  }

  @override
  Future<void> deleteNotification({required String id}) async => await _supabase
      .client
      .from(_notificationsCollection)
      .delete()
      .eq('id', id);

  @override
  Future<PageRemoteEntity<NotificationRemoteEntity>> getNotifications({
    required String receiverUserId,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _supabase.client
        .from(_notificationsCollection)
        .select()
        .eq('receiver_user_id', receiverUserId)
        .range(startIndex, endIndex)
        .order('created_at', ascending: false)
        .count(CountOption.exact);

    return PageRemoteEntity<NotificationRemoteEntity>(
      content: result.data
          .map<NotificationRemoteEntity>(
            (json) => NotificationRemoteEntity.fromJson(json: json),
          )
          .toList(),
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<NotificationRemoteEntity> updateNotification({
    required NotificationRemoteEntity notification,
  }) async {
    final result = await _supabase.client
        .from(_notificationsCollection)
        .update(notification.toJson())
        .eq('id', notification.id)
        .select()
        .single();

    return NotificationRemoteEntity.fromJson(json: result);
  }
}
