import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/search_users/models/search_users_state.dart';
import 'package:folly/features/search_users/search_users_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/user_tile.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SearchUsersMobileLayout extends ConsumerStatefulWidget {
  const SearchUsersMobileLayout({super.key});

  @override
  ConsumerState<SearchUsersMobileLayout> createState() =>
      _SearchUsersMobileLayoutState();
}

class _SearchUsersMobileLayoutState
    extends ConsumerState<SearchUsersMobileLayout> {
  final TextEditingController _searchController = TextEditingController();
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 200.0) {
        ref.read(searchUsersProvider.notifier).nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchUsersProvider);

    return Padding(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: Column(
        children: [
          BaseTextField(
            controller: _searchController,
            hint: 'search user',
            icon: state.status.isData
                ? PhosphorIcons.x()
                : PhosphorIcons.magnifyingGlass(),
            onSubmitted: (query) =>
                ref.read(searchUsersProvider.notifier).search(query: query),
            onTapIcon: () {
              if (state.status.isData) {
                _searchController.clear();
                ref.read(searchUsersProvider.notifier).reset();
              } else {
                ref
                    .read(searchUsersProvider.notifier)
                    .search(query: _searchController.text);
              }
            },
            errorText: state.invalidQuery
                ? context.l10n.you_must_type_at_least_x_characters(3)
                : null,
          ),
          switch (state.status) {
            SearchUsersStatus.initial => const SizedBox(),
            SearchUsersStatus.loading => const Expanded(
              child: Center(child: CircularProgressIndicator()),
            ),
            SearchUsersStatus.data => Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: ListView.separated(
                  shrinkWrap: true,
                  controller: _scrollController,
                  padding: const EdgeInsets.only(bottom: AppDimens.xl),
                  itemBuilder: (context, index) {
                    if (index == state.searchUsers.length && !state.isLast) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final user = state.searchUsers[index];

                    return UserTile(
                      name: user.name,
                      username: user.username,
                      imageUrl: user.photoPath,
                      onTap: () => context.pushNamed(
                        Paths.userProfile.name,
                        extra: ProfileParams(user: user),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(),
                  itemCount: state.isLast
                      ? state.searchUsers.length
                      : state.searchUsers.length + 1,
                ),
              ),
            ),
            SearchUsersStatus.empty => const Expanded(
              child: Center(child: Text('No users found')),
            ),
            SearchUsersStatus.error => const Expanded(
              child: Center(child: Text('Error')),
            ),
          },
        ],
      ),
    );
  }
}
