import 'package:domain/domain.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<StoryEntity> stories;
  final FriendEntity? friend;
  final int followers;
  final int following;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
    this.friend,
    this.followers = 0,
    this.following = 0,
  });

  @override
  List<Object?> get props => [status, stories, friend, followers, following];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
    FriendEntity? friend,
    int? followers,
    int? following,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    friend: friend ?? this.friend,
    followers: followers ?? this.followers,
    following: following ?? this.following,
  );

  ProfileState clearRequest() => ProfileState(
    status: status,
    stories: stories,
    friend: null,
    followers: followers,
    following: following,
  );
}
