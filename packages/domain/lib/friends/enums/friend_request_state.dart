enum FriendRequestState {
  following(value: 1),
  requested(value: 3),
  friend(value: 2),
  none(value: 0);

  final int value;

  const FriendRequestState({required this.value});

  factory FriendRequestState.fromInt(int value) {
    switch (value) {
      case 1:
        return FriendRequestState.following;
      case 2:
        return FriendRequestState.friend;

      default:
        return FriendRequestState.none;
    }
  }
}
