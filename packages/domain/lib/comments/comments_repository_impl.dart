import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/comments/comments_repository.dart';
import 'package:domain/comments/models/comment_entity.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/users/models/user_entity.dart';

class CommentsRepositoryImpl implements CommentsRepository {
  final CommentsRemoteDatasource commentsRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;

  const CommentsRepositoryImpl({
    required this.commentsRemoteDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<Result<CommentEntity>> createComment({
    required CommentEntity comment,
  }) async {
    try {
      final result = await commentsRemoteDatasource.createComment(
        comment: comment.remote,
      );

      return Result.success(result.toEntity(user: comment.user));
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteComment({required String id}) async {
    try {
      final result = await commentsRemoteDatasource.deleteComment(id: id);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<CommentEntity>>> getComments({
    required String storyId,
    required String uid,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      List<CommentEntity> comments = [];
      final commentsResult = await commentsRemoteDatasource.getComments(
        storyId: storyId,
        page: page,
        size: size,
        total: total,
      );

      for (var comment in commentsResult.content) {
        final user = await userRemoteDatasource.getUser(uid: comment.uid);

        comments.add(comment.toEntity(user: user.entity));
      }

      return Result.success(
        PageEntity(
          content: comments,
          page: page,
          totalPages: commentsResult.totalPages,
          total: commentsResult.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<int>> getCommentsCount({required String storyId}) async {
    try {
      final result = await commentsRemoteDatasource.getCommentsCount(
        storyId: storyId,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
