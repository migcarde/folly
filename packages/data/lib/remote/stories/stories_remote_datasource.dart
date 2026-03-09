import 'dart:io';

import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/stories/models/story_remote_entity.dart';

abstract class StoriesRemoteDatasource {
  Future<StoryRemoteEntity> uploadStory({
    required String uid,
    required String title,
    required File file,
    required String challengeId,
  });
  Future<PageRemoteEntity<StoryRemoteEntity>> getStories({
    required List<String> uids,
    required int page,
    int size,
    int? total,
  });
  Future<PageRemoteEntity<StoryRemoteEntity>> getStoriesFromUser({
    required String uid,
    required int page,
    int size,
    int? total,
  });
  Future<StoryRemoteEntity> getStory({required String storyId});
  Future<StoryRemoteEntity> updateStory({required StoryRemoteEntity story});
}
