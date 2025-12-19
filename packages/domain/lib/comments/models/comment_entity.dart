import 'package:data/remote/comments/models/comment_remote_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String text;
  final String storyId;
  final UserEntity user;
  final List<CommentEntity> replies;
  final String? parentCommentId;

  const CommentEntity({
    required this.id,
    required this.text,
    required this.storyId,
    required this.user,
    required this.replies,
    this.parentCommentId,
  });

  @override
  List<Object?> get props => [
    id,
    text,
    storyId,
    user,
    replies,
    parentCommentId,
  ];

  CommentRemoteEntity get remote => CommentRemoteEntity(
    id: id,
    text: text,
    storyId: storyId,
    uid: user.uid,
    parentCommentId: parentCommentId,
  );
}

extension CommentRemoteEntityExtensions on CommentRemoteEntity {
  CommentEntity toEntity({
    required UserEntity user,
    List<CommentEntity> replies = const [],
  }) => CommentEntity(
    id: id,
    text: text,
    storyId: storyId,
    user: user,
    replies: replies,
    parentCommentId: parentCommentId,
  );
}
