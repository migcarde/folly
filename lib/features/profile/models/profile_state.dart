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
  final int page;
  final int totalPages;
  final int? total;

  const ProfileState({
    this.status = ProfileStatus.loading,
    this.stories = const [],
    this.friend,
    this.followers = 0,
    this.following = 0,
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [
    status,
    stories,
    friend,
    followers,
    following,
    page,
    totalPages,
    total,
  ];

  ProfileState copyWith({
    ProfileStatus? status,
    List<StoryEntity>? stories,
    UserEntity? user,
    FriendEntity? friend,
    int? followers,
    int? following,
    int? page,
    int? totalPages,
    int? total,
  }) => ProfileState(
    status: status ?? this.status,
    stories: stories ?? this.stories,
    friend: friend ?? this.friend,
    followers: followers ?? this.followers,
    following: following ?? this.following,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  ProfileState clearRequest() => ProfileState(
    status: status,
    stories: stories,
    friend: null,
    followers: followers,
    following: following,
    page: page,
    totalPages: totalPages,
    total: total,
  );

  bool get isLast => (page + 1) >= totalPages;
}
