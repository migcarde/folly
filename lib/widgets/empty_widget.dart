import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/button_size.dart';
import 'package:lottie/lottie.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({
    super.key,
    required this.title,
    required this.message,
    this.buttonText,
    this.onTap,
  });

  final String title;
  final String message;
  final String? buttonText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return Column(
      children: [
        Lottie.asset('assets/lotties/empty.json', height: 200.0, repeat: false),
        Text(
          title,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(message, textAlign: TextAlign.center),
        if (buttonText != null && onTap != null)
          Padding(
            padding: const EdgeInsets.only(top: AppDimens.m),
            child: BaseButton(
              text: buttonText!,
              onTap: () => onTap?.call(),
              size: ButtonSize.small,
            ),
          ),
      ],
    );
  }
}
