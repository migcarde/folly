import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:folly/features/friends/enums/friend_type.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/user_tile.dart';
import 'package:go_router/go_router.dart';

class FriendsMobileLayout extends StatelessWidget {
  const FriendsMobileLayout({super.key, required this.type});

  final FriendType type;

  @override
  Widget build(BuildContext context) {
    //! TODO: Add pagination
    return ListView.separated(
      itemBuilder: (context, index) {
        final friend = friends[index];

        return UserTile(
          name: friend.name,
          username: friend.username,
          imageUrl: friend.photoPath,
          onTap: () => context.push(Paths.userProfile.route, extra: friend),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
      itemCount: friends.length,
    );
  }
}
