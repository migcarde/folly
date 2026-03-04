import 'package:data/remote/feeds/feed_remote_datasource.dart';
import 'package:data/remote/feeds/models/feed_remote_entity.dart';
import 'package:data/remote/models/page_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FeedRemoteDatasourceImpl extends FeedRemoteDatasource {
  final Supabase _instance = Supabase.instance;

  static const _feedsCollection = 'Feeds';

  @override
  Future<void> createFeed({
    required String uid,
    required String storyId,
  }) async => await _instance.client.functions.invoke(
    'story-feed-writer',
    method: HttpMethod.post,
    body: {'user_id': uid, 'story_id': storyId},
  );

  @override
  Future<PageRemoteEntity<FeedRemoteEntity>> getFeed({
    required String userId,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _instance.client
        .from(_feedsCollection)
        .select()
        .eq('user_id', userId)
        .range(startIndex, endIndex)
        .order('created_at', ascending: false)
        .count(CountOption.exact);

    return PageRemoteEntity(
      content: result.data
          .map((json) => FeedRemoteEntity.fromJson(json: json))
          .toList(),
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }
  
  @override
  Future<void> updateFeed({required FeedRemoteEntity feed}) async => await _instance.client
      .from(_feedsCollection)
      .update(feed.toJson())
      .eq('id', feed.id);
}
