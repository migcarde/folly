import 'dart:io';

abstract class StoriesRemoteDatasource {
  Future<void> init();
  Future<void> uploadStory({required File file});
}
