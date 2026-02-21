import 'package:flutter/widgets.dart';

extension ScrollControllerExtensions on ScrollController {
  static const int _animationDuration = 300;

  void scrollToTop() => animateTo(
    0,
    duration: const Duration(milliseconds: _animationDuration),
    curve: Curves.easeInOut,
  );
}
