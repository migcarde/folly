import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/likes/likes_repository_impl.dart';
import 'package:domain/likes/models/like_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class LikesRepository {
  Future<Result<LikeEntity>> likeStory({
    required String storyId,
    required String uid,
  });
  Future<Result<void>> unlikeStory({required String likeId});
  Future<Result<LikeEntity?>> getStoryLike({
    required String storyId,
    required String uid,
  });
  Future<Result<int>> getStoryLikesCount({required String storyId});
  Future<Result<LikeEntity?>> getCommentLike({
    required String commentId,
    required String uid,
  });
  Future<Result<int>> getCommentLikesCount({required String commentId});
}

final likesRepositoryProvider = Provider.autoDispose<LikesRepository>(
  (ref) => LikesRepositoryImpl(
    likesRemoteDatasource: ref.read(likesRemoteDatasourceProvider),
  ),
);
