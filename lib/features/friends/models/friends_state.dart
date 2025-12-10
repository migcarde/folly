import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum FriendsStatus {
  loading,
  empty,
  data;

  bool get isLoading => this == FriendsStatus.loading;
}

class FriendsState extends Equatable {
  final FriendsStatus status;
  final List<UserEntity> friends;
  final int page;
  final int totalPages;
  final int? total;

  const FriendsState({
    this.status = FriendsStatus.loading,
    this.friends = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [status, friends, page, totalPages, total];

  FriendsState copyWith({
    FriendsStatus? status,
    List<UserEntity>? friends,
    int? page,
    int? totalPages,
    int? total,
  }) => FriendsState(
    status: status ?? this.status,
    friends: friends ?? this.friends,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) >= totalPages;
}
