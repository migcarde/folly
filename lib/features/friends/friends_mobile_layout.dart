import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/friends/friends_notifier.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/routes/paths.dart';
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

    return state.when(
      data: (data) => ListView.separated(
        itemBuilder: (context, index) {
          if (index == data.friends.length && !data.isLast) {
            return const Center(child: CircularProgressIndicator());
          }

          final friend = data.friends[index];

          return UserTile(
            name: friend.name,
            username: friend.username,
            imageUrl: friend.photoPath,
            onTap: () => context.push(Paths.userProfile.route, extra: friend),
          );
        },
        separatorBuilder: (context, index) => const Divider(),
        itemCount: data.friends.length,
      ),
      error: (e, strackTrace) =>
          const SizedBox(), //! TODO: Replace with error message
      loading: () => const Center(),
    );
  }
}
