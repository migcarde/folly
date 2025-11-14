import 'package:domain/base/result.dart';
import 'package:domain/challenges/challenges_repository_impl.dart';
import 'package:domain/challenges/models/challenge_entity.dart';
import 'package:domain/domain.dart';
import 'package:riverpod/riverpod.dart';

abstract class ChallengesRepository {
  Future<Result<String>> createChallenge({
    required String uid,
    required String languageCode,
  });
  Future<Result<void>> updateChallenge({required ChallengeEntity challenge});
  Future<Result<ChallengeEntity?>> getUserChallenge({required String uid});
  Future<Result<void>> deleteUserChallenge({required String id});
}

final challengeRepositoryProvider = Provider<ChallengesRepository>(
  (ref) => ChallengesRepositoryImpl(
    challengesRemoteDatasource: ref.watch(challengeRemoteDatasourceProvider),
  ),
);
