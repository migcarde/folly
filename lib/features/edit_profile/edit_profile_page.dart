import 'package:flutter/material.dart';
import 'package:folly/features/edit_profile/edit_profile_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: EditProfileMobileLayout());
  }
}
