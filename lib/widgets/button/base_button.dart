import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/widgets/button/button_size.dart';
import 'package:folly/widgets/button/button_type.dart';

class BaseButton extends StatelessWidget {
  const BaseButton({
    super.key,
    required this.text,
    required this.onTap,
    this.type = ButtonType.normal,
    this.size = ButtonSize.large,
    this.leftIcon,
  });

  final String text;
  final VoidCallback onTap;
  final ButtonType type;
  final ButtonSize size;
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
          alignment: size.isSmall ? null : Alignment.center,
          padding: size.isSmall
              ? const EdgeInsets.symmetric(
                  horizontal: AppDimens.l,
                  vertical: AppDimens.s,
                )
              : const EdgeInsets.all(AppDimens.buttonPadding),
          decoration: BoxDecoration(
            color: style.backgroundColor,
            borderRadius: BorderRadius.circular(AppDimens.buttonRadius),
            border: Border.all(color: style.borderColor, width: 1.0),
          ),
          child: Row(
            mainAxisSize: size.isSmall ? MainAxisSize.min : MainAxisSize.max,
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
