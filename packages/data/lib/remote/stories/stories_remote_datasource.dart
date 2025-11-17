import 'dart:io';

import 'package:data/remote/stories/models/story_remote_entity.dart';

abstract class StoriesRemoteDatasource {
  Future<void> uploadStory({
    required String uid,
    required String title,
    required File file,
    required String challengeId,
  });

  Future<List<StoryRemoteEntity>> getStories({required List<String> uids});
}
