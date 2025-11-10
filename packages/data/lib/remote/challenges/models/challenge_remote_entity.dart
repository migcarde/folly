import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChallengeRemoteEntity extends Equatable {
  final String id;
  final String uid;
  final String text;
  final bool isCompleted;
  final DateTime date;

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
    required String id,
    required Map<String, dynamic> json,
  }) => ChallengeRemoteEntity(
    id: id,
    uid: json['uid'],
    text: json['text'],
    isCompleted: json['isCompleted'],
    date: (json['date'] as Timestamp).toDate(),
  );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'text': text,
    'isCompleted': isCompleted,
    'date': date,
  };
}
