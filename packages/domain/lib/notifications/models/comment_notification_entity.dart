import 'package:data/remote/notifications/models/comment_notification_remote_entity.dart';
import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/notifications/models/notification_entity.dart';
import 'package:domain/users/models/user_entity.dart';

class CommentNotificationEntity extends NotificationEntity {
  final String commentId;

  const CommentNotificationEntity({
    required super.id,
    required super.type,
    required super.createdAt,
    required super.isRead,
    required super.receiverUser,
    super.senderUser,
    super.contentId,
    required this.commentId,
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
    String? commentId,
  }) => CommentNotificationEntity(
    id: id ?? this.id,
    type: type ?? this.type,
    createdAt: createdAt ?? this.createdAt,
    isRead: isRead ?? this.isRead,
    receiverUser: receiverUser ?? this.receiverUser,
    senderUser: senderUser ?? this.senderUser,
    contentId: contentId ?? this.contentId,
    commentId: commentId ?? this.commentId,
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
    commentId,
  ];

  @override
  NotificationRemoteEntity get remoteEntity => CommentNotificationRemoteEntity(
    id: id,
    senderUserId: senderUser?.uid ?? '',
    receiverUserId: receiverUser.uid,
    type: type.value,
    createdAt: createdAt,
    isRead: isRead,
    contentId: contentId,
    commentId: commentId,
  );
}
