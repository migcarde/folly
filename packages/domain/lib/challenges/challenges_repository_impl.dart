import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/challenges/challenges_repository.dart';
import 'package:domain/challenges/models/challenge_entity.dart';

class ChallengesRepositoryImpl implements ChallengesRepository {
  final ChallengesRemoteDatasource challengesRemoteDatasource;

  const ChallengesRepositoryImpl({required this.challengesRemoteDatasource});

  @override
  Future<Result<String>> createChallenge({
    required String uid,
    required String languageCode,
  }) async {
    try {
      final result = await challengesRemoteDatasource.createChallenge(
        uid: uid,
        languageCode: languageCode,
      );

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> init() async {
    try {
      await challengesRemoteDatasource.init();

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<ChallengeEntity?>> getUserChallenge({
    required String uid,
  }) async {
    try {
      final result = await challengesRemoteDatasource.getUserChallenge(
        uid: uid,
      );

      return Result.success(result?.entity);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> updateChallenge({
    required ChallengeEntity challenge,
  }) async {
    try {
      await challengesRemoteDatasource.updateChallenge(
        challenge: challenge.remoteEntity,
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteUserChallenge({required String id}) async {
    try {
      await challengesRemoteDatasource.deleteUserChallenge(id: id);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
