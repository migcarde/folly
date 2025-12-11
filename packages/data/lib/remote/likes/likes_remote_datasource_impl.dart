import 'package:data/remote/likes/likes_remote_datasource.dart';
import 'package:data/remote/likes/models/like_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LikesRemoteDatasourceImpl extends LikesRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  static const _likesCollection = 'Likes';

  @override
  Future<LikeRemoteEntity> createLike({required LikeRemoteEntity like}) async {
    final result = await _supabase.client
        .from(_likesCollection)
        .insert(like.toJson())
        .select()
        .single();

    return LikeRemoteEntity.fromJson(json: result);
  }

  @override
  Future<void> deleteLike({required String id}) async =>
      await _supabase.client.from(_likesCollection).delete().eq('id', id);

  @override
  Future<LikeRemoteEntity?> getLike({
    required String storyId,
    required String uid,
  }) async {
    final result = await _supabase.client
        .from(_likesCollection)
        .select()
        .eq('story_id', storyId)
        .eq('uid', uid)
        .maybeSingle();

    return result == null ? null : LikeRemoteEntity.fromJson(json: result);
  }

  @override
  Future<int> getLikesCount({required String storyId}) async {
    final result = await _supabase.client
        .from(_likesCollection)
        .select()
        .eq('story_id', storyId)
        .count(CountOption.exact);

    return result.count;
  }
}
