import 'package:data/remote/notifications/models/like_notification_remote_entity.dart';
import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/users/models/user_entity.dart';

class LikeNotificationEntity extends NotificationEntity {
  const LikeNotificationEntity({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.isRead,
    required super.receiverUser,
    required super.senderUser,
    required super.contentId,
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
  }) => LikeNotificationEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    receiverUser: receiverUser ?? this.receiverUser,
    senderUser: senderUser ?? this.senderUser,
    contentId: contentId ?? this.contentId,
  );

  @override
  List<Object?> get props => [
    id,
    type,
    createdAt,
    isRead,
    receiverUser,
    senderUser,
    contentId,
  ];

  @override
  NotificationRemoteEntity get remoteEntity => LikeNotificationRemoteEntity(
    id: id,
    senderUserId: senderUser?.uid ?? '',
    receiverUserId: receiverUser.uid,
    type: type.value,
    createdAt: createdAt,
    isRead: isRead,
    contentId: contentId,
  );
}
