import 'package:domain/base/result.dart';
import 'package:domain/comments/comments_repository_impl.dart';
import 'package:domain/comments/models/comment_entity.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/models/page_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class CommentsRepository {
  Future<Result<CommentEntity>> createComment({required CommentEntity comment});
  Future<Result<void>> deleteComment({required String id});
  Future<Result<PageEntity<CommentEntity>>> getComments({
    required String storyId,
    required String uid,
    required int page,
    int size = 10,
    int? total,
  });
  Future<Result<int>> getCommentsCount({required String storyId});
  Future<Result<void>> updateComment({required CommentEntity comment});
  Future<Result<PageEntity<CommentEntity>>> getReplies({
    required String parentCommentId,
    required int page,
    int size = 5,
    int? total,
  });
}

final commentsRepositoryProvider = Provider<CommentsRepository>(
  (ref) => CommentsRepositoryImpl(
    commentsRemoteDatasource: ref.watch(commentsRemoteDatasourceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
  ),
);
