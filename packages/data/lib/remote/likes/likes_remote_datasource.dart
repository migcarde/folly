import 'package:data/remote/likes/models/like_remote_entity.dart';

abstract class LikesRemoteDatasource {
  Future<LikeRemoteEntity> createLike({required LikeRemoteEntity like});
  Future<void> deleteLike({required String id});
  Future<LikeRemoteEntity?> getLike({
    required String storyId,
    required String uid,
  });
  Future<int> getLikesCount({required String storyId});
}
