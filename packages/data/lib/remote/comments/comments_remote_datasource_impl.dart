import 'package:data/remote/comments/comments_remote_datasource.dart';
import 'package:data/remote/comments/models/comment_remote_entity.dart';
import 'package:data/remote/models/page_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommentsRemoteDatasourceImpl extends CommentsRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  static const _commentsCollection = 'Comments';

  @override
  Future<CommentRemoteEntity> createComment({
    required CommentRemoteEntity comment,
  }) async {
    final result = await _supabase.client
        .from(_commentsCollection)
        .insert(comment.toJson())
        .select()
        .single();

    return CommentRemoteEntity.fromJson(json: result);
  }

  @override
  Future<void> deleteComment({required String id}) async =>
      await _supabase.client.from(_commentsCollection).delete().eq('id', id);

  @override
  Future<PageRemoteEntity<CommentRemoteEntity>> getComments({
    required String storyId,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _supabase.client
        .from(_commentsCollection)
        .select()
        .eq('story_id', storyId)
        .isFilter('parent_comment_id', null)
        .range(startIndex, endIndex)
        .order('created_at', ascending: false)
        .count(CountOption.exact);

    return PageRemoteEntity(
      content: result.data
          .map((json) => CommentRemoteEntity.fromJson(json: json))
          .toList(),
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<int> getCommentsCount({required String storyId}) async {
    final result = await _supabase.client
        .from(_commentsCollection)
        .select()
        .eq('story_id', storyId)
        .count(CountOption.exact);

    return result.count;
  }

  @override
  Future<PageRemoteEntity<CommentRemoteEntity>> getReplies({
    required String parentCommentId,
    required int page,
    int size = 5,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _supabase.client
        .from(_commentsCollection)
        .select()
        .eq('parent_comment_id', parentCommentId)
        .range(startIndex, endIndex)
        .order('created_at', ascending: true)
        .count(CountOption.exact);

    return PageRemoteEntity(
      content: result.data
          .map((json) => CommentRemoteEntity.fromJson(json: json))
          .toList(),
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<void> updateComment({required CommentRemoteEntity comment}) async {
    await _supabase.client
        .from(_commentsCollection)
        .update(comment.toJson())
        .eq('id', comment.id);
  }
}
