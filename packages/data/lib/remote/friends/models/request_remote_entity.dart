import 'package:equatable/equatable.dart';

class FriendRemoteEntity extends Equatable {
  final String id;
  final String uid;
  final String receiverUid;
  final int state;

  const FriendRemoteEntity({
    required this.id,
    required this.uid,
    required this.receiverUid,
    this.state = 0,
  });

  @override
  List<Object?> get props => [id, uid, receiverUid];

  factory FriendRemoteEntity.fromJson({required Map<String, dynamic> json}) =>
      FriendRemoteEntity(
        id: json['id'],
        uid: json['uid'],
        receiverUid: json['receiver_uid'],
        state: json['state'],
      );

  Map<String, dynamic> toJson() => {
    'uid': uid,
    'receiver_uid': receiverUid,
    'state': state,
  };
}
