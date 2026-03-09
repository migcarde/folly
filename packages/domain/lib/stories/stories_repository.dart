import 'dart:io';

import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/stories/models/story_entity.dart';
import 'package:domain/stories/stories_repository_impl.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class StoriesRepository {
  Future<Result<void>> uploadFile({
    required String uid,
    required String title,
    required File file,
    required String challengeId,
  });
  Future<Result<PageEntity<StoryEntity>>> getStories({
    required List<String> uids,
    required int page,
    int size = 10,
    int? total,
  });
  Future<Result<PageEntity<StoryEntity>>> getStoriesFromUser({
    required UserEntity user,
    required int page,
    int size = 10,
    int? total,
  });
  Future<Result<StoryEntity>> getStory({required String storyId});
  Future<Result<StoryEntity>> updateStory({required StoryEntity story});
}

final storiesRepositoryProvider = Provider.autoDispose<StoriesRepository>(
  (ref) => StoriesRepositoryImpl(
    storiesRemoteDatasource: ref.watch(storiesRemoteDatasourceProvider),
    challengesRemoteDatasource: ref.watch(challengeRemoteDatasourceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
    feedRemoteDatasource: ref.watch(feedRemoteDatasourceProvider),
  ),
);
