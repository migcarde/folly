import 'package:equatable/equatable.dart';

class NotificationRemoteEntity extends Equatable {
  const NotificationRemoteEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.isRead,
    required this.receiverUserId,
    this.userId,
    this.contentId,
  });

  final String id;
  final int type;
  final DateTime createdAt;
  final bool isRead;
  final String receiverUserId;
  final String? userId;
  final String? contentId;

  factory NotificationRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    return NotificationRemoteEntity(
      id: json['id'],
      type: json['type'],
      createdAt: DateTime.parse(json['created_at']),
      isRead: json['is_read'],
      receiverUserId: json['receiver_user_id'],
      userId: json['user_id'],
      contentId: json['content_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'is_read': isRead,
    'receiver_user_id': receiverUserId,
    if (userId != null) 'user_id': userId,
    if (contentId != null) 'content_id': contentId,
  };

  @override
  List<Object?> get props => [
    id,
    type,
    createdAt,
    isRead,
    receiverUserId,
    userId,
    contentId,
  ];
}
