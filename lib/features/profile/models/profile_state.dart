import 'package:domain/domain.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<StoryEntity> stories;
  final FriendEntity? friend;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
    this.friend,
  });

  @override
  List<Object?> get props => [status, stories, friend];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
    FriendEntity? friend,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    friend: friend ?? this.friend,
  );

  ProfileState clearRequest() =>
      ProfileState(status: status, stories: stories, friend: null);
}
