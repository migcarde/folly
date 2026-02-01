import 'package:data/remote/notifications/models/notification_remote_entity.dart';
import 'package:domain/notifications/enums/notification_type.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class NotificationEntity extends Equatable {
  final String id;
  final NotificationType type;
  final DateTime createdAt;
  final bool isRead;
  final UserEntity receiverUser;
  final UserEntity? user;
  final String? contentId;

  const NotificationEntity({
    required this.id,
    required this.type,
    required this.createdAt,
    required this.isRead,
    required this.receiverUser,
    this.user,
    this.contentId,
  });

  @override
  List<Object?> get props => [
    id,
    type,
    createdAt,
    isRead,
    receiverUser,
    user,
    contentId,
  ];

  NotificationEntity copyWith({
    String? id,
    NotificationType? type,
    DateTime? createdAt,
    bool? isRead,
    UserEntity? receiverUser,
    UserEntity? user,
    String? contentId,
  }) {
    return NotificationEntity(
      id: id ?? this.id,
      type: type ?? this.type,
      createdAt: createdAt ?? this.createdAt,
      isRead: isRead ?? this.isRead,
      receiverUser: receiverUser ?? this.receiverUser,
      user: user ?? this.user,
      contentId: contentId ?? this.contentId,
    );
  }

  NotificationRemoteEntity get remoteEntity => NotificationRemoteEntity(
    id: id,
    type: type.value,
    createdAt: createdAt,
    isRead: isRead,
    receiverUserId: receiverUser.uid,
    userId: user?.uid,
    contentId: contentId,
  );
}

extension NotificationRemoteEntityExtensions on NotificationRemoteEntity {
  NotificationEntity toEntity({
    required UserEntity receiverUser,
    UserEntity? user,
  }) => NotificationEntity(
    id: id,
    type: NotificationType.fromInt(type),
    createdAt: createdAt,
    isRead: isRead,
    receiverUser: receiverUser,
    user: user,
    contentId: contentId,
  );
}
