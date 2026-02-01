import 'package:flutter/widgets.dart';
import 'package:folly/extensions/build_context_extensions.dart';

class BaseDivider extends StatelessWidget {
  const BaseDivider({super.key, this.thickness = 1.0, this.color});

  final double thickness;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: thickness,
      decoration: BoxDecoration(
        color: color ?? context.theme.colorScheme.outlineVariant,
      ),
    );
  }
}
