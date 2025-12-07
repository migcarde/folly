import 'package:domain/requests/enums/friend_request_state.dart';
import 'package:domain/requests/models/request_entity.dart';
import 'package:equatable/equatable.dart';

class FriendRequestEntity extends Equatable {
  final RequestEntity? request;
  final FriendRequestState state;

  const FriendRequestEntity({this.request, required this.state});

  @override
  List<Object?> get props => [request, state];

  FriendRequestEntity copyWith({
    RequestEntity? request,
    FriendRequestState? state,
  }) {
    return FriendRequestEntity(
      request: request ?? this.request,
      state: state ?? this.state,
    );
  }
}
