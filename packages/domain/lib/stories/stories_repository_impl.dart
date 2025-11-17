import 'dart:io';

import 'package:data/data.dart';
import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:domain/base/result.dart';
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
  Future<Result<List<StoryEntity>>> getStories({
    required List<String> uids,
  }) async {
    try {
      final storiesResult = await storiesRemoteDatasource.getStories(
        uids: uids,
      );

      List<StoryEntity> result = [];

      for (final story in storiesResult) {
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

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
