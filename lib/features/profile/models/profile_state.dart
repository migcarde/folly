import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum ProfileStatus { loading, success, error }

class ProfileState extends Equatable {
  final ProfileStatus status;
  final List<StoryEntity> stories;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
  });

  @override
  List<Object?> get props => [status, stories];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
  );
}
