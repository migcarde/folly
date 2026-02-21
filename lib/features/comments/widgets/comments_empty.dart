import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CommentsEmpty extends StatelessWidget {
  const CommentsEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          PhosphorIcons.chatCircleSlash(),
          size: AppDimens.xl,
          color: theme.colorScheme.outline,
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimens.m),
          child: Text(
            l10n.no_yet(l10n.comments),
            style: context.theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),
        ),
      ],
    );
  }
}
