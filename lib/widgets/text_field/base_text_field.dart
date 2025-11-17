import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/widgets/click_detector.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';

enum BaseTextFieldType {
  normal,
  password,
  textArea;

  bool get isPassword => this == BaseTextFieldType.password;
  bool get isTextArea => this == BaseTextFieldType.textArea;
}

class BaseTextField extends StatelessWidget {
  const BaseTextField({
    super.key,
    required this.hint,
    this.enabled = true,
    this.icon,
    this.errorText,
    this.controller,
    this.textType = BaseTextFieldType.normal,
    this.onSubmitted,
    this.onTapIcon,
    this.type = TextFieldType.initial,
    this.prefixText,
    this.textStyle,
  });

  final String hint;
  final bool enabled;
  final TextFieldType type;

  final IconData? icon;
  final String? errorText;
  final TextEditingController? controller;
  final BaseTextFieldType textType;
  final Function(String)? onSubmitted;
  final VoidCallback? onTapIcon;
  final String? prefixText;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    final style = type.getStyle(Theme.of(context));

    return TextField(
      controller: controller,
      obscureText: textType.isPassword,
      enableSuggestions: !textType.isPassword,
      autocorrect: !textType.isPassword,
      onSubmitted: onSubmitted,
      minLines: textType.isTextArea && !type.isNone ? 3 : null,
      maxLines: textType.isTextArea ? null : 1,
      style: textStyle,
      decoration: InputDecoration(
        hintText: hint,
        prefixText: prefixText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: enabled,
        suffixIcon: ClickDetector(
          onTap: onTapIcon ?? () {},
          child: Icon(icon, color: Theme.of(context).primaryColor),
        ),
        border: OutlineInputBorder(
          borderSide: style.borderColor != Colors.transparent
              ? BorderSide(color: style.borderColor, width: 2.0)
              : BorderSide.none,
          borderRadius: const BorderRadius.all(
            Radius.circular(AppDimens.cardRadius),
          ),
        ),
        filled: true,
        fillColor: style.backgroundColor,
        errorText: errorText,
        errorMaxLines: 6,
      ),
    );
  }
}
