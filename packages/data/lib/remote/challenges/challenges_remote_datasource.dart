import 'package:data/remote/challenges/models/challenge_remote_entity.dart';

abstract class ChallengesRemoteDatasource {
  Future<String> createChallenge({
    required String uid,
    required String languageCode,
  });
  Future<void> updateChallenge({required ChallengeRemoteEntity challenge});
  Future<ChallengeRemoteEntity?> getUserChallenge({required String uid});
  Future<void> deleteUserChallenge({required String id});
  Future<ChallengeRemoteEntity> getChallenge({required String id});
}
