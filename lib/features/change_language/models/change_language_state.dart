import 'dart:ui';

import 'package:equatable/equatable.dart';

enum ChangeLanguageStatus {
  initial,
  loading,
  success,
  error;

  bool get isLoading => this == ChangeLanguageStatus.loading;
  bool get isSuccess => this == ChangeLanguageStatus.success;
  bool get isError => this == ChangeLanguageStatus.error;
}

class ChangeLanguageState extends Equatable {
  final ChangeLanguageStatus status;
  final Locale? selectedLocale;

  const ChangeLanguageState({
    this.status = ChangeLanguageStatus.initial,
    this.selectedLocale,
  });

  @override
  List<Object?> get props => [status, selectedLocale];

  ChangeLanguageState copyWith({
    ChangeLanguageStatus? status,
    Locale? selectedLocale,
  }) => ChangeLanguageState(
    status: status ?? this.status,
    selectedLocale: selectedLocale ?? this.selectedLocale,
  );
}
