import 'package:equatable/equatable.dart';
import 'package:folly/features/friends/enums/friend_type.dart';

class FriendsViewModel extends Equatable {
  final FriendType friendType;
  final String uid;

  const FriendsViewModel({required this.friendType, required this.uid});

  @override
  List<Object?> get props => [friendType, uid];
}
