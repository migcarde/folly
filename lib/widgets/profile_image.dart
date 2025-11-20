import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key, this.imageUrl, this.size = 24.0});

  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: theme.colorScheme.outlineVariant,
        borderRadius: BorderRadius.circular(AppDimens.circularRadius),
      ),
      child: ClipOval(
        child: imageUrl != null && imageUrl!.isNotEmpty
            ? Image.network(
                imageUrl!,
                width: size,
                height: size,
                fit: BoxFit.cover,
              )
            : Icon(
                PhosphorIcons.user(PhosphorIconsStyle.fill),
                size: size * 0.6,
                color: theme.primaryColor,
              ),
      ),
    );
  }
}
