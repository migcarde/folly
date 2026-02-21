import 'package:data/remote/notifications/models/notification_remote_entity.dart';

class FollowNotificationRemoteEntity extends NotificationRemoteEntity {
  const FollowNotificationRemoteEntity({
    required super.id,
    required super.senderUserId,
    required super.receiverUserId,
    required super.type,
    required super.createdAt,
    super.isRead = false,
  });

  @override
  List<Object?> get props => [
    id,
    senderUserId,
    receiverUserId,
    type,
    createdAt,
    isRead,
  ];

  factory FollowNotificationRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) => FollowNotificationRemoteEntity(
    id: json['id'],
    senderUserId: json['sender_user_id'],
    receiverUserId: json['receiver_user_id'],
    type: json['type'],
    createdAt: DateTime.parse(json['created_at']),
    isRead: json['is_read'],
  );

  @override
  Map<String, dynamic> toJson() => {
    if (id != '-1') 'id': id,
    'receiver_user_id': receiverUserId,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    if (senderUserId != null) 'sender_user_id': senderUserId,
    'is_read': isRead,
  };

  @override
  Map<String, dynamic> toRemoteNotificationJson() => {
    'receiver_user_id': receiverUserId,
    'type': type,
    'created_at': createdAt.toIso8601String(),
    if (senderUserId != null) 'sender_user_id': senderUserId,
    'is_read': isRead,
  };
}
