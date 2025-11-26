import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/legacy.dart';

class LocalizationNotifier extends StateNotifier<Locale?> {
  LocalizationNotifier() : super(null);

  void selectLocale({required Locale locale}) {
    state = locale;
  }
}

final localizationProvider =
    StateNotifierProvider.autoDispose<LocalizationNotifier, Locale?>(
      (ref) => LocalizationNotifier(),
    );
