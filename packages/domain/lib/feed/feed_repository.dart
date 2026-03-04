import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/feed/feed_repository_impl.dart';
import 'package:domain/feed/models/feed_entity.dart';
import 'package:domain/models/page_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class FeedRepository {
  Future<Result<void>> createFeed({
    required String uid,
    required String storyId,
  });
  Future<Result<PageEntity<FeedEntity>>> getFeed({
    required String userId,
    required int page,
    int size = 10,
    int? total,
  });
  Future<Result<void>> updateFeed({required FeedEntity feed});
}

final feedRepositoryProvider = Provider<FeedRepository>((ref) {
  return FeedRepositoryImpl(
    feedRemoteDatasource: ref.watch(feedRemoteDatasourceProvider),
    storiesRemoteDatasource: ref.watch(storiesRemoteDatasourceProvider),
    userRemoteDataSource: ref.watch(userRemoteDatasourceProvider),
    challengesRemoteDatasource: ref.watch(challengeRemoteDatasourceProvider),
  );
});
