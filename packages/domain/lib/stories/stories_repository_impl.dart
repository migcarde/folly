import 'dart:io';

import 'package:data/data.dart';
import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/stories/models/story_entity.dart';
import 'package:domain/stories/stories_repository.dart';
import 'package:domain/users/models/user_entity.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDatasource storiesRemoteDatasource;
  final ChallengesRemoteDatasource challengesRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;

  const StoriesRepositoryImpl({
    required this.storiesRemoteDatasource,
    required this.challengesRemoteDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<Result<void>> uploadFile({
    required String uid,
    required String title,
    required File file,
    required String challengeId,
  }) async {
    try {
      final result = await storiesRemoteDatasource.uploadStory(
        uid: uid,
        title: title,
        file: file,
        challengeId: challengeId,
      );

      final challenge = await challengesRemoteDatasource.getChallenge(
        id: challengeId,
      );

      await challengesRemoteDatasource.updateChallenge(
        challenge: ChallengeRemoteEntity(
          id: challenge.id,
          uid: challenge.uid,
          text: challenge.text,
          date: challenge.date,
          isCompleted: true,
        ),
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<StoryEntity>>> getStories({
    required List<String> uids,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      final storiesResult = await storiesRemoteDatasource.getStories(
        uids: uids,
        page: page,
        size: size,
        total: total,
      );

      List<StoryEntity> result = [];

      for (final story in storiesResult.content) {
        final storyInfoResult = await Future.wait([
          userRemoteDatasource.getUser(uid: story.uid),
          challengesRemoteDatasource.getChallenge(id: story.challengeId),
        ]);

        final user = storyInfoResult[0] as UserRemoteEntity;
        final challenge = storyInfoResult[1] as ChallengeRemoteEntity;

        result.add(
          story.toEntity(user: user.entity, challenge: challenge.text),
        );
      }

      return Result.success(
        PageEntity(
          content: result,
          page: page,
          totalPages: storiesResult.totalPages,
          total: storiesResult.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<StoryEntity>>> getStoriesFromUser({
    required UserEntity user,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      List<StoryEntity> result = [];

      final stories = await storiesRemoteDatasource.getStoriesFromUser(
        uid: user.uid,
        page: page,
        size: size,
        total: total,
      );

      for (final story in stories.content) {
        final challenge = await challengesRemoteDatasource.getChallenge(
          id: story.challengeId,
        );

        result.add(story.toEntity(user: user, challenge: challenge.text));
      }

      return Result.success(
        PageEntity(
          content: result,
          page: page,
          totalPages: stories.totalPages,
          total: stories.total,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<StoryEntity>> updateStory({required StoryEntity story}) async {
    try {
      final result = await storiesRemoteDatasource.updateStory(
        story: story.remoteEntity,
      );

      return Result.success(
        result.toEntity(user: story.user, challenge: story.challenge),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }
}
