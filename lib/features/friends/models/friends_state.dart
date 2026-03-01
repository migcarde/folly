import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

class FriendsState extends Equatable {
  final List<UserEntity> friends;
  final int page;
  final int totalPages;
  final int? total;

  const FriendsState({
    this.friends = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [friends, page, totalPages, total];

  FriendsState copyWith({
    List<UserEntity>? friends,
    int? page,
    int? totalPages,
    int? total,
  }) => FriendsState(
    friends: friends ?? this.friends,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) >= totalPages;
}
