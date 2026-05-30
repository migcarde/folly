import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/button_size.dart';

class BaseDialog extends StatelessWidget {
  const BaseDialog({
    super.key,
    required this.parentContext,
    required this.title,
    required this.body,
    required this.onTapConfirm,
    required this.onTapCancel,
    required this.confirmButtonText,
    required this.cancelButtonText,
  });

  final BuildContext parentContext;
  final String title;
  final String body;
  final String confirmButtonText;
  final String cancelButtonText;
  final VoidCallback onTapConfirm;
  final VoidCallback onTapCancel;

  @override
  Widget build(BuildContext context) {
    final theme = parentContext.theme;
    return Center(
      child: Container(
        margin: const EdgeInsets.all(AppDimens.screenPadding),
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimens.cardPaddingHorizontal,
          vertical: AppDimens.cardPaddingVertical,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(AppDimens.cardRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: AppDimens.s),
              child: Text(body),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(top: AppDimens.l),
                child: Wrap(
                  alignment: WrapAlignment.end,
                  spacing: AppDimens.m,
                  runSpacing: AppDimens.m,
                  crossAxisAlignment: WrapCrossAlignment.center,

                  children: [
                    GestureDetector(
                      onTap: onTapCancel,
                      child: Text(cancelButtonText),
                    ),
                    BaseButton(
                      text: confirmButtonText,
                      onTap: onTapConfirm,
                      size: ButtonSize.small,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}