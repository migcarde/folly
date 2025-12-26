import 'package:data/remote/comments/models/comment_remote_entity.dart';
import 'package:data/remote/models/page_remote_entity.dart';

abstract class CommentsRemoteDatasource {
  Future<CommentRemoteEntity> createComment({
    required CommentRemoteEntity comment,
  });
  Future<void> deleteComment({required String id});
  Future<PageRemoteEntity<CommentRemoteEntity>> getComments({
    required String storyId,
    required int page,
    int size = 10,
    int? total,
  });
  Future<int> getCommentsCount({required String storyId});
  Future<PageRemoteEntity<CommentRemoteEntity>> getReplies({
    required String parentCommentId,
    required int page,
    int size = 5,
    int? total,
  });
  Future<void> updateComment({required CommentRemoteEntity comment});
}
