import 'package:data/remote/feeds/models/feed_remote_entity.dart';
import 'package:data/remote/models/page_remote_entity.dart';

abstract class FeedRemoteDatasource {
  Future<void> createFeed({required String uid, required String storyId});
  Future<PageRemoteEntity<FeedRemoteEntity>> getFeed({
    required String userId,
    required int page,
    int size = 10,
    int? total,
  });
  Future<void> updateFeed({required FeedRemoteEntity feed});
}
