import 'dart:ui';

import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/change_language/models/change_language_state.dart';

class ChangeLanguageNotifier extends StateNotifier<ChangeLanguageState> {
  ChangeLanguageNotifier({
    required this.userRepository,
    required this.authNotifier,
  }) : super(const ChangeLanguageState());

  final UserRepository userRepository;
  final AuthNotifier authNotifier;

  Future<void> selectLanguage({required Locale locale}) async =>
      state = state.copyWith(selectedLocale: locale);

  Future<void> save() async {
    if (authNotifier.user != null) {
      state = state.copyWith(status: ChangeLanguageStatus.loading);
      final user = authNotifier.user!;

      final result = await userRepository.saveUser(
        user: user.copyWith(
          photoPath: user.photoPath,
          locale: state.selectedLocale.toString(),
        ),
      );

      result.when(
        (_) => state = state.copyWith(status: ChangeLanguageStatus.success),
        (_, __) => state = state.copyWith(status: ChangeLanguageStatus.error),
      );
    }
  }
}

final changeLanguageProvider =
    StateNotifierProvider.autoDispose<
      ChangeLanguageNotifier,
      ChangeLanguageState
    >(
      (ref) => ChangeLanguageNotifier(
        userRepository: ref.watch(userRepositoryProvider),
        authNotifier: ref.watch(authNotifierProvider),
      ),
    );
