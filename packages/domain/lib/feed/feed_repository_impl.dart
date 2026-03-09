import 'package:data/data.dart';
import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/feed/feed_repository.dart';
import 'package:domain/feed/models/feed_entity.dart';
import 'package:domain/models/page_entity.dart';
import 'package:domain/stories/models/story_entity.dart';
import 'package:domain/users/models/user_entity.dart';

class FeedRepositoryImpl implements FeedRepository {
  final FeedRemoteDatasource feedRemoteDatasource;
  final StoriesRemoteDatasource storiesRemoteDatasource;
  final UserRemoteDataSource userRemoteDataSource;
  final ChallengesRemoteDatasource challengesRemoteDatasource;

  const FeedRepositoryImpl({
    required this.feedRemoteDatasource,
    required this.storiesRemoteDatasource,
    required this.userRemoteDataSource,
    required this.challengesRemoteDatasource,
  });

  @override
  Future<Result<void>> createFeed({
    required String uid,
    required String storyId,
  }) async {
    try {
      await feedRemoteDatasource.createFeed(uid: uid, storyId: storyId);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<PageEntity<FeedEntity>>> getFeed({
    required String userId,
    required int page,
    int size = 10,
    int? total,
  }) async {
    try {
      List<FeedEntity> result = [];
      final feedResult = await feedRemoteDatasource.getFeed(
        userId: userId,
        page: page,
        size: size,
        total: total,
      );

      for (var feed in feedResult.content) {
        final story = await storiesRemoteDatasource.getStory(
          storyId: feed.storyId,
        );
        final remoteResults = await Future.wait([
          userRemoteDataSource.getUser(uid: story.uid),
          challengesRemoteDatasource.getChallenge(id: story.challengeId),
        ]);
        final userRemoteEntity = remoteResults[0] as UserRemoteEntity;
        final challengeRemoteEntity = remoteResults[1] as ChallengeRemoteEntity;

        result.add(
          feed.toEntity(
            story: story.toEntity(
              user: userRemoteEntity.entity,
              challenge: challengeRemoteEntity.text,
            ),
          ),
        );
      }

      return Result.success(
        PageEntity<FeedEntity>(
          content: result,
          total: feedResult.total,
          totalPages: feedResult.totalPages,
          page: page,
        ),
      );
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateFeed({required FeedEntity feed}) async {
    try {
      await feedRemoteDatasource.updateFeed(feed: feed.remoteEntity);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
