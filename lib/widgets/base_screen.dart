import 'package:flutter/widgets.dart';
import 'package:folly/core/app_dimens.dart';

class BaseScreen extends StatelessWidget {
  const BaseScreen({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppDimens.screenPadding),
      child: child,
    );
  }
}
