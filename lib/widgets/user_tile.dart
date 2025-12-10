import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/widgets/profile_image.dart';

class UserTile extends StatelessWidget {
  const UserTile({
    super.key,
    required this.name,
    required this.username,
    required this.imageUrl,
    required this.onTap,
  });

  final String name;
  final String username;
  final String imageUrl;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          ProfileImage(imageUrl: imageUrl, size: 48.0),
          Padding(
            padding: const EdgeInsets.only(left: AppDimens.s),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text(name), Text('@$username')],
            ),
          ),
        ],
      ),
    );
  }
}
