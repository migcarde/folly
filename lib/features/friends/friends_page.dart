import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/friends/enums/friend_type.dart';
import 'package:folly/features/friends/friends_mobile_layout.dart';
import 'package:folly/features/friends/models/friends_view_model.dart';
import 'package:folly/widgets/base_scaffold.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key, required this.viewModel});

  final FriendsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BaseScaffold(
      title: switch (viewModel.friendType) {
        FriendType.followers => l10n.followers,
        FriendType.following => l10n.following,
      },
      child: FriendsMobileLayout(viewModel: viewModel),
    );
  }
}
