import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, error }

enum RequestStatus {
  friend,
  pending,
  none;

  bool get isFriend => this == RequestStatus.friend;
  bool get isPending => this == RequestStatus.pending;
  bool get isNone => this == RequestStatus.none;
}

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<StoryEntity> stories;
  final RequestStatus requestStatus;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
    this.requestStatus = RequestStatus.none,
  });

  @override
  List<Object?> get props => [status, stories, requestStatus];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
    RequestStatus? requestStatus,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    requestStatus: requestStatus ?? this.requestStatus,
  );
}
