import 'package:data/remote/likes/models/like_remote_entity.dart';

abstract class LikesRemoteDatasource {
  Future<LikeRemoteEntity> createLike({required LikeRemoteEntity like});
  Future<void> deleteLike({required String id});
  Future<LikeRemoteEntity?> getStoryLike({
    required String storyId,
    required String uid,
  });
  Future<int> getStoryLikesCount({required String storyId});
  Future<LikeRemoteEntity?> getCommentLike({
    required String commentId,
    required String uid,
  });
  Future<int> getCommentLikesCount({required String commentId});
}
