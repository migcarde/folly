import 'package:domain/users/models/user_entity.dart';
import 'package:equatable/equatable.dart';

enum SearchUsersStatus { initial, loading, data, empty, error }

class SearchUsersState extends Equatable {
  final SearchUsersStatus status;
  final String query;
  final List<UserEntity> searchUsers;
  final int page;
  final int totalPages;
  final int? total;

  const SearchUsersState({
    this.status = SearchUsersStatus.initial,
    this.query = '',
    this.searchUsers = const [],
    this.page = 0,
    this.totalPages = 0,
    this.total,
  });

  @override
  List<Object?> get props => [
    status,
    query,
    searchUsers,
    page,
    totalPages,
    total,
  ];

  SearchUsersState copyWith({
    SearchUsersStatus? status,
    String? query,
    List<UserEntity>? searchUsers,
    int? page,
    int? totalPages,
    int? total,
  }) => SearchUsersState(
    status: status ?? this.status,
    query: query ?? this.query,
    searchUsers: searchUsers ?? this.searchUsers,
    page: page ?? this.page,
    totalPages: totalPages ?? this.totalPages,
    total: total ?? this.total,
  );

  bool get isLast => (page + 1) == totalPages;
}
