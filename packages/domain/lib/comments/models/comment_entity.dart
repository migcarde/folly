import 'package:data/remote/comments/models/comment_remote_entity.dart';
import 'package:domain/likes/models/like_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class CommentEntity extends Equatable {
  final String id;
  final String text;
  final int likes;
  final String storyId;
  final UserEntity user;
  final String? parentCommentId;
  final LikeEntity? like;

  const CommentEntity({
    required this.id,
    required this.text,
    required this.likes,
    required this.like,
    required this.storyId,
    required this.user,
    this.parentCommentId,
  });

  @override
  List<Object?> get props => [
    id,
    text,
    likes,
    like,
    storyId,
    user,
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
    required int likes,
    LikeEntity? like,
  }) => CommentEntity(
    id: id,
    text: text,
    likes: likes,
    like: like,
    storyId: storyId,
    user: user,
    parentCommentId: parentCommentId,
  );
}
