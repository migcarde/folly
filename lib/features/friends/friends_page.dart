import 'package:flutter/material.dart';
import 'package:folly/features/friends/enums/friend_type.dart';
import 'package:folly/features/friends/friends_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key, required this.type});

  final FriendType type;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: FriendsMobileLayout(type: type));
  }
}
