import 'package:domain/domain.dart';
import 'package:domain/requests/models/friend_request_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<StoryEntity> stories;
  final FriendRequestEntity? friendRequest;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
    this.friendRequest,
  });

  @override
  List<Object?> get props => [status, stories, friendRequest];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
    FriendRequestEntity? friendRequest,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    friendRequest: friendRequest ?? this.friendRequest,
  );

  ProfileState clearRequest() =>
      ProfileState(status: status, stories: stories, friendRequest: null);
}
