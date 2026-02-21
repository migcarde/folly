import 'package:data/data.dart';
import 'package:data/remote/notifications/notifications_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/notifications/notifications_repository.dart';
import 'package:domain/users/models/user_entity.dart';

class NotificationsRepositoryImpl implements NotificationsRepository {
  final NotificationsRemoteDatasource notificationsRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;

  NotificationsRepositoryImpl({
    required this.notificationsRemoteDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<Result<void>> deleteNotification({required String id}) async {
    try {
      await notificationsRemoteDatasource.deleteNotification(id: id);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<NotificationEntity>>> getNotifications({
    required String receiverUserId,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      final notificationsResult = await notificationsRemoteDatasource
          .getNotifications(
            receiverUserId: receiverUserId,
            page: page,
            size: size,
            total: total,
          );

      List<NotificationEntity> result = [];

      for (var notificationRemote in notificationsResult.content) {
        UserEntity? user;
        final receiverUser = await userRemoteDatasource.getUser(
          uid: notificationRemote.receiverUserId,
        );

        if (notificationRemote.senderUserId != null) {
          final userData = await userRemoteDatasource.getUser(
            uid: notificationRemote.senderUserId!,
          );
          user = userData.entity;
        }

        result.add(
          notificationRemote.toEntity(
            receiverUser: receiverUser.entity,
            user: user,
          ),
        );
      }
      return Result.success(
        PageEntity(
          content: result,
          page: page,
          totalPages: notificationsResult.totalPages,
          total: notificationsResult.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<NotificationEntity>> updateNotification({
    required NotificationEntity notification,
  }) async {
    try {
      final result = await notificationsRemoteDatasource.updateNotification(
        notification: notification.remoteEntity,
      );
      return Result.success(
        result.toEntity(
          receiverUser: notification.receiverUser,
          user: notification.senderUser,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }
}
