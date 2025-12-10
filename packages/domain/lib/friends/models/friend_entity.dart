import 'package:data/remote/friends/models/request_remote_entity.dart';
import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:equatable/equatable.dart';

class FriendEntity extends Equatable {
  final String id;
  final String uid;
  final String receiverUid;
  final FriendRequestState state;

  const FriendEntity({
    required this.id,
    required this.uid,
    required this.receiverUid,
    this.state = FriendRequestState.none,
  });

  @override
  List<Object?> get props => [id, uid, receiverUid, state];

  FriendEntity copyWith({
    String? id,
    String? uid,
    String? receiverUid,
    FriendRequestState? state,
  }) {
    return FriendEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      receiverUid: receiverUid ?? this.receiverUid,
      state: state ?? this.state,
    );
  }

  FriendRemoteEntity get remoteEntity => FriendRemoteEntity(
    id: id,
    uid: uid,
    receiverUid: receiverUid,
    state: state.value,
  );
}

extension FriendRemoteEntityExtensions on FriendRemoteEntity {
  FriendEntity get entity => FriendEntity(
    id: id,
    uid: uid,
    receiverUid: receiverUid,
    state: FriendRequestState.fromInt(state),
  );
}
