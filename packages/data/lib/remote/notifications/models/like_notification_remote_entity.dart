import 'package:data/remote/notifications/models/notification_remote_entity.dart';

class LikeNotificationRemoteEntity extends NotificationRemoteEntity {
  const LikeNotificationRemoteEntity({
    required super.id,
    required super.senderUserId,
    required super.receiverUserId,
    required super.type,
    required super.createdAt,
    required super.contentId,
    super.isRead = false,
  });

  @override
  List<Object?> get props => [
    senderUserId,
    receiverUserId,
    type,
    createdAt,
    contentId,
    isRead,
  ];

  @override
  Map<String, dynamic> toJson() => {
    if (id != '-1') 'id': id,
    'receiver_user_id': receiverUserId,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    'content_id': contentId,
    if (senderUserId != null) 'sender_user_id': senderUserId,
    'is_read': isRead,
  };

  @override
  Map<String, dynamic> toRemoteNotificationJson() => {
    'receiver_user_id': receiverUserId,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    'content_id': contentId,
  };

  factory LikeNotificationRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) => LikeNotificationRemoteEntity(
    id: json['id'],
    receiverUserId: json['receiver_user_id'],
    type: json['type'],
    createdAt: DateTime.parse(json['created_at']),
    contentId: json['content_id'],
    senderUserId: json['sender_user_id'],
    isRead: json['is_read'],
  );
}
