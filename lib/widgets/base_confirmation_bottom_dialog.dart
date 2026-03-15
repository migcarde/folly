import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:go_router/go_router.dart';

class BaseConfirmationBottomDialog extends StatelessWidget {
  const BaseConfirmationBottomDialog({
    super.key,
    required this.parentContext,
    required this.title,
    required this.text,
    required this.onTapConfirm,
    this.confirmText,
  });

  final BuildContext parentContext;
  final String title;
  final String text;
  final String? confirmText;
  final VoidCallback onTapConfirm;

  @override
  Widget build(BuildContext context) {
    final l10n = parentContext.l10n;
    final theme = parentContext.theme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(text),
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.l),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () => context.pop(),
                    child: Text(
                      l10n.cancel,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.error,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.pop();

                      onTapConfirm();
                    },
                    child: Text(
                      confirmText ?? parentContext.l10n.accept,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
