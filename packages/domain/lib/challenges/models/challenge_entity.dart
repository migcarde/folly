import 'package:data/remote/challenges/models/challenge_remote_entity.dart';
import 'package:equatable/equatable.dart';

class ChallengeEntity extends Equatable {
  final String id;
  final String uid;
  final String text;
  final bool isCompleted;
  final DateTime date;

  const ChallengeEntity({
    required this.id,
    required this.uid,
    required this.text,
    required this.isCompleted,
    required this.date,
  });

  @override
  List<Object?> get props => [id, uid, text, isCompleted, date];

  ChallengeRemoteEntity get remoteEntity => ChallengeRemoteEntity(
    id: id,
    uid: uid,
    text: text,
    isCompleted: isCompleted,
    date: date,
  );
}

extension ChallengeRemoteEntityExtensions on ChallengeRemoteEntity {
  ChallengeEntity get entity => ChallengeEntity(
    id: id,
    uid: uid,
    text: text,
    isCompleted: isCompleted,
    date: date,
  );
}
