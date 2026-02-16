import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/profile/profile_mobile_layout.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key, required this.params});

  final ProfileParams params;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(body: ProfileMobileLayout(params: params));
  }
}
