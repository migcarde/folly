import 'dart:async';

import 'package:domain/auth/auth_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ResetPasswordRequestNotifier extends AsyncNotifier<bool> {
  @override
  FutureOr<bool> build() {
    return false;
  }

  Future<void> sendResetPasswordRequest(String email) async {
    state = const AsyncLoading();
    final result = await ref
        .read(authRepositoryProvider)
        .sendPasswordResetEmail(email: email);

    result.when(
      (_) => state = const AsyncData(true),
      (failure, stacktrace) => state = AsyncError(failure, stacktrace),
    );
  }
}

final resetPasswordRequestNotifierProvider =
    AsyncNotifierProvider<ResetPasswordRequestNotifier, bool>(
      () => ResetPasswordRequestNotifier(),
    );
