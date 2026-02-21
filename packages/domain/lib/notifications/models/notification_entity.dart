import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/notifications/models/comment_notification_entity.dart';
import 'package:domain/notifications/models/follow_notification_entity.dart';
import 'package:domain/notifications/models/like_notification_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationEntity extends Equatable {
  final String id;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;
  final UserEntity receiverUser;
  final UserEntity? senderUser;
  final String? contentId;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.isRead,
    required this.receiverUser,
    this.senderUser,
    this.contentId,
  });

  NotificationEntity copyWith({
    String? id,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    UserEntity? receiverUser,
    UserEntity? senderUser,
    String? contentId,
  });

  NotificationRemoteEntity get remoteEntity;
}

extension NotificationRemoteEntityExtensions on NotificationRemoteEntity {
  NotificationEntity toEntity({
    required UserEntity receiverUser,
    UserEntity? user,
  }) {
    final type = NotificationType.fromInt(this.type);

    switch (type) {
      case NotificationType.like:
        return LikeNotificationEntity(
          id: id,
          type: type,
          createdAt: createdAt,
          isRead: isRead,
          receiverUser: receiverUser,
          senderUser: user,
          contentId: contentId,
        );
      case NotificationType.comment:
        return CommentNotificationEntity(
          id: id,
          type: type,
          createdAt: createdAt,
          isRead: isRead,
          receiverUser: receiverUser,
          senderUser: user,
          contentId: contentId,
          commentId: contentId ?? '',
        );
      case NotificationType.follow:
        return FollowNotificationEntity(
          id: id,
          type: type,
          createdAt: createdAt,
          isRead: isRead,
          receiverUser: receiverUser,
          senderUser: user,
        );
    }
  }
}
