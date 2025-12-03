import 'package:equatable/equatable.dart';

class RequestRemoteEntity extends Equatable {
  final String id;
  final String uid;
  final String receiverUid;

  const RequestRemoteEntity({
    required this.id,
    required this.uid,
    required this.receiverUid,
  });

  @override
  List<Object?> get props => [id, uid, receiverUid];

  factory RequestRemoteEntity.fromJson({required Map<String, dynamic> json}) =>
      RequestRemoteEntity(
        id: json['id'],
        uid: json['uid'],
        receiverUid: json['receiver_uid'],
      );

  Map<String, dynamic> toJson() => {'uid': uid, 'receiver_uid': receiverUid};
}
