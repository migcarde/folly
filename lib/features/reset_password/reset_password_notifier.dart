import 'dart:async';

import 'package:domain/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/string_extensions.dart';
import 'package:folly/features/reset_password/enums/reset_password_status.dart';

class ResetPasswordNotifier extends AsyncNotifier<ResetPasswordStatus> {
  @override
  FutureOr<ResetPasswordStatus> build() {
    return ResetPasswordStatus.none;
  }

  Future<void> resetPassword({
    required String password,
    required String repeatPassword,
  }) async {
    if (password != repeatPassword) {
      state = AsyncValue<ResetPasswordStatus>.error(
        ResetPasswordStatus.passwordsDoesNotMatch,
        StackTrace.current,
      );
    } else if (!password.isStrongPassword) {
      state = AsyncValue<ResetPasswordStatus>.error(
        ResetPasswordStatus.weakPassword,
        StackTrace.current,
      );
    } else {
      state = const AsyncValue.loading();

      final authRepository = ref.read(authRepositoryProvider);
      final result = await authRepository.updatePassword(password: password);

      result.when(
        (_) => state = AsyncValue.data(ResetPasswordStatus.success),
        (failure, stackTrace) => state = AsyncValue<ResetPasswordStatus>.error(
          ResetPasswordStatus.unknownError,
          stackTrace,
        ),
      );
    }
  }
}

final resetPasswordNotifier =
    AsyncNotifierProvider<ResetPasswordNotifier, ResetPasswordStatus>(
      () => ResetPasswordNotifier(),
    );
