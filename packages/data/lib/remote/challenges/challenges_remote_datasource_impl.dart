import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChallengesRemoteDatasourceImpl implements ChallengesRemoteDatasource {
  static const _challengesCollection = 'Challenges';

  final Supabase _supabase = Supabase.instance;

  @override
  Future<String> createChallenge({
    required String uid,
    required String languageCode,
  }) async {
    try {
      final String follyPrompt =
          """
Act as a whimsical and slightly mischievous daily challenge generator.
Create one unique, harmless, and slightly silly daily folly challenge.
It must be a physical or social task that takes less than 5 minutes and is purely for fun.
Avoid dangerous, sexual, or adult content; keep it appropriate for all ages.
Write exactly one short, clear, direct instruction.
Do not use bullets, numbering, quotes, decoration, or markdown.
Do not repeat the example or produce a generic variation of it.
Use a different category than the example: choose one of these
- a physical action with a real object,
- a brief social interaction,
- or a playful imaginative gesture.
Prefer a concrete object, setting, or social target.
Use different themes, words, and verbs each time.

Examples:
Tap a spoon lightly on the table as if it were a tiny drum.
Say “hello” to a plant and thank it for being green.
Trace the outline of an invisible butterfly in the air with your finger.

Now generate a fresh new daily folly challenge in $languageCode:
""";

      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);

      final response = await _supabase.client.functions.invoke(
        'hyper-worker',
        body: {'prompt': follyPrompt},
      );

      final text = (response.data['response'] as String?) ?? '';

      final challenge = ChallengeRemoteEntity(
        id: '',
        uid: uid,
        text: text.replaceAll('"', ''),
        isCompleted: false,
        date: startOfDay.toString(),
      );

      await _supabase.client
          .from(_challengesCollection)
          .insert(challenge.toJson());

      return challenge.text;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ChallengeRemoteEntity?> getUserChallenge({required String uid}) async {
    final result = await _supabase.client
        .from(_challengesCollection)
        .select()
        .eq('user_id', uid)
        .order('created_at', ascending: false);

    return result.isEmpty
        ? null
        : ChallengeRemoteEntity.fromJson(json: result.first);
  }

  @override
  Future<void> updateChallenge({
    required ChallengeRemoteEntity challenge,
  }) async => await _supabase.client
      .from(_challengesCollection)
      .update(challenge.toJson())
      .eq('id', challenge.id);

  @override
  Future<void> deleteUserChallenge({required String id}) async =>
      await _supabase.client.from(_challengesCollection).delete().eq('id', id);

  @override
  Future<ChallengeRemoteEntity> getChallenge({required String id}) async {
    final result = await _supabase.client
        .from(_challengesCollection)
        .select()
        .eq('id', id)
        .single();

    return ChallengeRemoteEntity.fromJson(json: result);
  }
}
