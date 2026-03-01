import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/friends/friends_notifier.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/empty_widget.dart';
import 'package:folly/widgets/exception_widget.dart';
import 'package:folly/widgets/user_tile.dart';
import 'package:go_router/go_router.dart';

class FriendsMobileLayout extends ConsumerStatefulWidget {
  const FriendsMobileLayout({super.key, required this.viewModel});

  final FriendsViewModel viewModel;

  @override
  ConsumerState<FriendsMobileLayout> createState() =>
      _FriendsMobileLayoutState();
}

class _FriendsMobileLayoutState extends ConsumerState<FriendsMobileLayout> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;

      if (currentScroll >= maxScroll - 200.0) {
        ref.read(friendsProvider(widget.viewModel).notifier).nextPage();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(friendsProvider(widget.viewModel));
    final l10n = context.l10n;

    return state.when(
      data: (data) {
        if (data.friends.isEmpty) {
          return Center(child: EmptyWidget(title: l10n.user(0)));
        } else {
          return ListView.separated(
            itemBuilder: (context, index) {
              if (index == data.friends.length && !data.isLast) {
                return const Center(child: CircularProgressIndicator());
              }

              final friend = data.friends[index];

              return UserTile(
                name: friend.name,
                username: friend.username,
                imageUrl: friend.photoPath,
                onTap: () =>
                    context.pushNamed(Paths.userProfile.name, extra: friend),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: data.friends.length,
          );
        }
      },
      error: (e, strackTrace) => const Center(child: ExceptionWidget()),
      loading: () => Center(child: CircularProgressIndicator()),
    );
  }
}
