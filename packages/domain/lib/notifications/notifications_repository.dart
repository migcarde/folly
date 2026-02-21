import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/notifications/notifications_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

abstract class NotificationsRepository {
  Future<Result<void>> deleteNotification({required String id});
  Future<Result<NotificationEntity>> updateNotification({
    required NotificationEntity notification,
  });
  Future<Result<PageEntity<NotificationEntity>>> getNotifications({
    required String receiverUserId,
    required int page,
    int size = 10,
    int? total,
  });
}

final notificationsRepositoryProvider =
    Provider.autoDispose<NotificationsRepository>(
      (ref) => NotificationsRepositoryImpl(
        notificationsRemoteDatasource: ref.read(
          notificationsRemoteDatasourceProvider,
        ),
        userRemoteDatasource: ref.read(userRemoteDatasourceProvider),
      ),
    );
