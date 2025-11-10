import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class ChallengesRemoteDatasourceImpl implements ChallengesRemoteDatasource {
  static const _geminiCollection = 'gemini';
  static const _challengesCollection = 'challenges';

  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<String> createChallenge({
    required String uid,
    required String languageCode,
  }) async {
    final String follyPrompt =
        """
    Act as a whimsical and slightly mischievous Challenge Generator. 
    Your task is to invent one unique, harmless, and slightly silly daily 'folly' challenge for a person to complete. 
    The challenge must be a physical or social task that takes less than 5 minutes and is purely for fun. Also it must avoid dangerous and sexual content and be appropriate for all ages.

    The output must be a short, clear, and direct instruction, formatted exactly as follows:
    [Specific Instruction/Task]

    Example:
    Spend 30 seconds interacting with an imaginary, elaborately decorated hat on your head.

    Now, generate the daily folly challenge in $languageCode:
    """;

    final result = await Gemini.instance.prompt(
      parts: [Part.text(follyPrompt)],
    );

    final today = DateTime.now();

    final challenge = ChallengeRemoteEntity(
      id: '',
      uid: uid,
      text: result?.output ?? '',
      isCompleted: false,
      date: DateTime(today.year, today.month, today.day),
    );

    await _instance.collection(_challengesCollection).add(challenge.toJson());

    return challenge.text;
  }

  @override
  Future<void> init() async {
    final result = await _instance
        .collection(_geminiCollection)
        .doc('key')
        .get();

    final apiKey = result.data()?['value'] ?? '';

    Gemini.init(apiKey: apiKey);
  }

  @override
  Future<ChallengeRemoteEntity?> getUserChallenge({required String uid}) async {
    final result = await _instance
        .collection(_challengesCollection)
        .where('uid', isEqualTo: uid)
        .limit(1)
        .get();

    return result.docs.isEmpty
        ? null
        : ChallengeRemoteEntity.fromJson(
            id: result.docs.first.id,
            json: result.docs.first.data(),
          );
  }

  @override
  Future<void> updateChallenge({
    required ChallengeRemoteEntity challenge,
  }) async => await _instance
      .collection(_challengesCollection)
      .doc(challenge.id)
      .set(challenge.toJson());

  @override
  Future<void> deleteUserChallenge({required String id}) async =>
      await _instance.collection(_challengesCollection).doc(id).delete();
}
