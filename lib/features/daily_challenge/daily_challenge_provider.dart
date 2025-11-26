import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/extensions/date_time_extensions.dart';
import 'package:folly/extensions/object_extensions.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/daily_challenge/models/daily_challenge_state.dart';

class DailyChallengeProvider extends StateNotifier<DailyChallengeState> {
  DailyChallengeProvider({
    required this.challengesRepository,
    required this.authNotifier,
  }) : super(DailyChallengeState());

  final ChallengesRepository challengesRepository;
  final AuthNotifier authNotifier;

  Future<void> init() async {
    if (authNotifier.user?.uid.isNotEmpty == true) {
      final result = await challengesRepository.getUserChallenge(
        uid: authNotifier.user!.uid,
      );

      result.when((challenge) async {
        final today = DateTime.now().startOfDay;
        if (challenge == null ||
            challenge.date.startOfDay.difference(today).inDays.abs() >= 1) {
          challenge?.let(
            (data) => challengesRepository.deleteUserChallenge(id: data.id),
          );
          await _createChallenge(
            uid: authNotifier.user!.uid,
            locale: authNotifier.user?.locale ?? 'en_US',
          );
        } else {
          state = state.copyWith(
            status: challenge.isCompleted
                ? DailyChallengeStatus.completed
                : DailyChallengeStatus.success,
            challenge: challenge.text,
          );
        }
      }, (_) => state.copyWith(status: DailyChallengeStatus.error));
    }
  }

  Future<void> _createChallenge({
    required String uid,
    required String locale,
  }) async {
    final result = await challengesRepository.createChallenge(
      uid: uid,
      languageCode: locale,
    );

    result.when(
      (challenge) => state = DailyChallengeState(
        status: DailyChallengeStatus.success,
        challenge: challenge,
      ),
      (failure) => state = state.copyWith(status: DailyChallengeStatus.error),
    );
  }
}

final dailyChallengeNotifierProvider =
    StateNotifierProvider<DailyChallengeProvider, DailyChallengeState>(
      (ref) => DailyChallengeProvider(
        challengesRepository: ref.watch(challengeRepositoryProvider),
        authNotifier: ref.watch(authNotifierProvider),
      ),
    );
