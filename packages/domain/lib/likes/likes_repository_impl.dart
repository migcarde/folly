import 'package:data/remote/likes/likes_remote_datasource.dart';
import 'package:data/remote/likes/models/like_remote_entity.dart';
import 'package:domain/base/result.dart';
import 'package:domain/likes/likes_repository.dart';
import 'package:domain/likes/models/like_entity.dart';

class LikesRepositoryImpl implements LikesRepository {
  final LikesRemoteDatasource likesRemoteDatasource;

  const LikesRepositoryImpl({required this.likesRemoteDatasource});

  @override
  Future<Result<LikeEntity>> likeStory({
    required String storyId,
    required String uid,
  }) async {
    try {
      final result = await likesRemoteDatasource.createLike(
        like: LikeRemoteEntity(id: storyId, uid: uid, storyId: storyId),
      );

      return Result.success(result.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> unlikeStory({required String likeId}) async {
    try {
      await likesRemoteDatasource.deleteLike(id: likeId);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<LikeEntity?>> getStoryLike({
    required String storyId,
    required String uid,
  }) async {
    try {
      final result = await likesRemoteDatasource.getStoryLike(
        storyId: storyId,
        uid: uid,
      );

      return Result.success(result?.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getStoryLikesCount({required String storyId}) async {
    try {
      final result = await likesRemoteDatasource.getStoryLikesCount(
        storyId: storyId,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<LikeEntity?>> getCommentLike({
    required String commentId,
    required String uid,
  }) async {
    try {
      final result = await likesRemoteDatasource.getCommentLike(
        commentId: commentId,
        uid: uid,
      );

      return Result.success(result?.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getCommentLikesCount({required String commentId}) async {
    try {
      final result = await likesRemoteDatasource.getCommentLikesCount(
        commentId: commentId,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
