import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:folly/features/profile/profile_mobile_layout.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.user});

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ProfileMobileLayout(user: user));
  }
}
