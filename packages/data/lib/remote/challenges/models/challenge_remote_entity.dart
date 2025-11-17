import 'package:equatable/equatable.dart';

class ChallengeRemoteEntity extends Equatable {
  final String id;
  final String uid;
  final String text;
  final bool isCompleted;
  final String date;

  const ChallengeRemoteEntity({
    required this.id,
    required this.uid,
    required this.text,
    required this.isCompleted,
    required this.date,
  });

  @override
  List<Object?> get props => [id, uid, text, isCompleted, date];

  factory ChallengeRemoteEntity.fromJson({
    required Map<String, dynamic> json,
  }) => ChallengeRemoteEntity(
    id: json['id'],
    uid: json['user_id'],
    text: json['text'],
    isCompleted: json['is_completed'],
    date: json['created_at'],
  );

  Map<String, dynamic> toJson() => {'text': text, 'is_completed': isCompleted};
}
