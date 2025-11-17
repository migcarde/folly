import 'package:equatable/equatable.dart';

enum DailyChallengeStatus {
  loading,
  success,
  error,
  completed;

  bool get isCompleted => this == DailyChallengeStatus.completed;
}

class DailyChallengeState extends Equatable {
  final DailyChallengeStatus status;
  final String challenge;

  const DailyChallengeState({
    this.status = DailyChallengeStatus.loading,
    this.challenge = '',
  });

  @override
  List<Object?> get props => [status, challenge];

  DailyChallengeState copyWith({
    DailyChallengeStatus? status,
    String? challenge,
  }) => DailyChallengeState(
    status: status ?? this.status,
    challenge: challenge ?? this.challenge,
  );
}
