import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:lottie/lottie.dart';

class ExceptionWidget extends StatelessWidget {
  const ExceptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset('assets/lotties/error.json', height: 200.0, repeat: false),
        Text(
          l10n.oops_something_went_wrong,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(l10n.please_try_again_later, textAlign: TextAlign.center),
      ],
    );
  }
}
