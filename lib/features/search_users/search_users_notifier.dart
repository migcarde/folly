import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/search_users/models/search_users_state.dart';

class SearchUsersNotifier extends StateNotifier<SearchUsersState> {
  SearchUsersNotifier({required this.userRepository})
    : super(const SearchUsersState());

  final UserRepository userRepository;

  Future<void> search({required String query}) async {
    reset();

    if (query.length < 3) {
      state = state.copyWith(invalidQuery: true);
    } else {
      state = state.copyWith(status: SearchUsersStatus.loading, query: query);

      await _searchUsers(query: query);
    }
  }

  Future<void> nextPage() async {
    if (!state.isLast) {
      state = state.copyWith(page: state.page + 1);
      await _searchUsers(query: state.query);
    }
  }

  void reset() => state = SearchUsersState();

  Future<void> _searchUsers({required String query}) async {
    final result = await userRepository.searchUsers(
      query: query,
      page: state.page,
      total: state.total,
    );

    result.when(
      (data) => state = state.copyWith(
        status: data.content.isEmpty
            ? SearchUsersStatus.empty
            : SearchUsersStatus.data,
        searchUsers: [...state.searchUsers, ...data.content],
        page: data.page,
        totalPages: data.totalPages,
        total: data.total,
      ),
      (_, __) => state = state.copyWith(status: SearchUsersStatus.error),
    );
  }
}

final searchUsersProvider =
    StateNotifierProvider.autoDispose<SearchUsersNotifier, SearchUsersState>(
      (ref) => SearchUsersNotifier(
        userRepository: ref.watch(userRepositoryProvider),
      ),
    );
