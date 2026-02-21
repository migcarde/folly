import 'package:data/remote/notifications/models/follow_notification_remote_entity.dart';
import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/users/models/user_entity.dart';

class FollowNotificationEntity extends NotificationEntity {
  const FollowNotificationEntity({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.isRead,
    required super.receiverUser,
    required super.senderUser,
  });

  @override
  NotificationEntity copyWith({
    String? id,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    UserEntity? receiverUser,
    UserEntity? senderUser,
    String? contentId,
  }) => FollowNotificationEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    receiverUser: receiverUser ?? this.receiverUser,
    senderUser: senderUser ?? this.senderUser,
  );

  @override
  List<Object?> get props => [
    id,
    type,
    createdAt,
    isRead,
    receiverUser,
    senderUser,
  ];

  @override
  NotificationRemoteEntity get remoteEntity => FollowNotificationRemoteEntity(
    id: id,
    senderUserId: senderUser?.uid ?? '',
    receiverUserId: receiverUser.uid,
    type: type.value,
    createdAt: createdAt,
    isRead: isRead,
  );
}
