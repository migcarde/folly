import 'package:data/remote/feeds/models/feed_remote_entity.dart';
import 'package:domain/stories/models/story_entity.dart';

class FeedEntity {
  final String id;
  final bool isRead;
  final StoryEntity story;

  FeedEntity({required this.id, required this.isRead, required this.story});

  FeedRemoteEntity get remoteEntity => FeedRemoteEntity(
    id: id,
    isRead: isRead,
    userId: story.user.uid,
    storyId: story.id,
    createdAt: '',
  );
}

extension FeedRemoteEntityExtension on FeedRemoteEntity {
  FeedEntity toEntity({required StoryEntity story}) =>
      FeedEntity(id: id, isRead: isRead, story: story);
}
