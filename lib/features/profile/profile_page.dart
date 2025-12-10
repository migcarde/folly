import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/profile/profile_mobile_layout.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: ProfileMobileLayout(
        user: user,
        isCurrentUser:
            ref.read(authNotifierProvider.notifier).user?.uid == user.uid,
      ),
    );
  }
}
