import 'package:data/remote/notifications/models/comment_notification_remote_entity.dart';
import 'package:data/remote/notifications/models/follow_notification_remote_entity.dart';
import 'package:data/remote/notifications/models/like_notification_remote_entity.dart';
import 'package:equatable/equatable.dart';

abstract class NotificationRemoteEntity extends Equatable {
  final String id;
  final String receiverUserId;
  final int type;
  final DateTime createdAt;
  final bool isRead;
  final String? senderUserId;
  final String? contentId;

  const NotificationRemoteEntity({
    required this.id,
    required this.receiverUserId,
    required this.type,
    required this.createdAt,
    this.isRead = false,
    this.senderUserId,
    this.contentId,
  });

  Map<String, dynamic> toJson();
  Map<String, dynamic> toRemoteNotificationJson();

  factory NotificationRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) {
    final type = json['type'] as int;

    switch (type) {
      case 0:
        return LikeNotificationRemoteEntity.fromJson(json: json);
      case 1:
        return CommentNotificationRemoteEntity.fromJson(json: json);
      case 2:
        return FollowNotificationRemoteEntity.fromJson(json: json);
      default:
        throw UnimplementedError('Notification type $type is not implemented');
    }
  }
}
