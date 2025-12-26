import 'package:data/remote/likes/models/like_remote_entity.dart';
import 'package:equatable/equatable.dart';

class LikeEntity extends Equatable {
  final String id;
  final String uid;
  final String? storyId;
  final String? commentId;

  const LikeEntity({
    required this.id,
    required this.uid,
    this.storyId,
    this.commentId,
  });

  @override
  List<Object?> get props => [id, uid, storyId, commentId];

  LikeRemoteEntity get remoteEntity => LikeRemoteEntity(
    id: id,
    uid: uid,
    storyId: storyId,
    commentId: commentId,
  );
}

extension LikeRemoteEntityExtensions on LikeRemoteEntity {
  LikeEntity get entity =>
      LikeEntity(id: id, uid: uid, storyId: storyId, commentId: commentId);
}
