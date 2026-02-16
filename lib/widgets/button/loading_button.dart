import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/core/container_decorators.dart';
import 'package:folly/widgets/button/button_type.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({
    super.key,
    required this.text,
    required this.onTap,
    required this.isLoading,
    this.type = ButtonType.normal,
    this.leftIcon,
  });

  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final ButtonType type;
  final IconData? leftIcon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = type.getButtonStyle(theme);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: double.infinity,
          height: AppDimens.buttonHeight,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(AppDimens.buttonPadding),
          decoration: ContainerDecorators.button(color: style.backgroundColor),
          child: isLoading
              ? FittedBox(
                  child: CircularProgressIndicator(color: style.textColor),
                )
              : Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    if (leftIcon != null)
                      Padding(
                        padding: const EdgeInsets.only(right: AppDimens.s),
                        child: Icon(leftIcon, color: style.textColor),
                      ),
                    Text(
                      text,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: style.textColor,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
