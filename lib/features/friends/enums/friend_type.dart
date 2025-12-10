enum FriendType {
  followers,
  following;

  bool get isFollowers => this == FriendType.followers;
  bool get isFollowing => this == FriendType.following;
}
