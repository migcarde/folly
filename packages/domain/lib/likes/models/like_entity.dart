import 'package:data/remote/likes/models/like_remote_entity.dart';
import 'package:equatable/equatable.dart';

class LikeEntity extends Equatable {
  final String id;
  final String uid;
  final String storyId;

  const LikeEntity({
    required this.id,
    required this.uid,
    required this.storyId,
  });

  @override
  List<Object?> get props => [id, uid, storyId];

  LikeRemoteEntity get remoteEntity =>
      LikeRemoteEntity(id: id, uid: uid, storyId: storyId);
}

extension LikeRemoteEntityExtensions on LikeRemoteEntity {
  LikeEntity get entity => LikeEntity(id: id, uid: uid, storyId: storyId);
}
