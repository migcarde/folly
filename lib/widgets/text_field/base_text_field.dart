import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/widgets/click_detector.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum BaseTextFieldType {
  normal,
  password,
  textArea,
  inlineTextArea;

  bool get isPassword => this == BaseTextFieldType.password;
  bool get isTextArea => this == BaseTextFieldType.textArea;
  bool get isInlineTextArea => this == BaseTextFieldType.inlineTextArea;
}

class BaseTextField extends StatefulWidget {
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
    this.maxLines,
  }) : assert(
         !((textType == BaseTextFieldType.normal ||
                 textType == BaseTextFieldType.password) &&
             maxLines != null),
         'maxLines cannot be used with BaseTextFieldType.textArea or BaseTextFieldType.inlineTextArea',
       );

  final String hint;
  final bool enabled;
  final TextFieldType type;

  final IconData? icon;
  final String? errorText;
  final TextEditingController? controller;
  final BaseTextFieldType textType;
  final Function(String value)? onSubmitted;
  final VoidCallback? onTapIcon;
  final String? prefixText;
  final TextStyle? textStyle;
  final int? maxLines;

  @override
  State<BaseTextField> createState() => _BaseTextFieldState();
}

class _BaseTextFieldState extends State<BaseTextField> {
  bool isHide = false;

  @override
  void initState() {
    setState(() {
      isHide = widget.textType.isPassword;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = widget.type.getStyle(Theme.of(context));

    return TextField(
      controller: widget.controller,
      obscureText: isHide,
      enableSuggestions: !widget.textType.isPassword,
      autocorrect: !widget.textType.isPassword,
      onSubmitted: widget.onSubmitted,
      minLines: widget.textType.isTextArea && !widget.type.isNone ? 3 : 1,
      maxLines: widget.textType.isTextArea || widget.textType.isInlineTextArea
          ? widget.maxLines
          : 1,
      style: widget.textStyle,
      decoration: InputDecoration(
        hintText: widget.hint,
        prefixText: widget.prefixText,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabled: widget.enabled,
        suffixIcon: ClickDetector(
          onTap: _onTap,
          child: Icon(_iconData, color: style.iconColor),
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
        errorText: widget.errorText,
        errorMaxLines: 6,
      ),
    );
  }

  void _onTap() {
    if (widget.textType.isPassword) {
      setState(() {
        isHide = !isHide;
      });
    } else {
      widget.onTapIcon?.call();
    }
  }

  IconData? get _iconData {
    if (widget.textType.isPassword) {
      return isHide ? PhosphorIcons.eyeSlash() : PhosphorIcons.eye();
    } else {
      return widget.icon;
    }
  }
}
