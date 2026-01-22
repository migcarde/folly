import 'dart:async';

import 'package:domain/auth/auth_repository.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/notifiers/models/auth_state.dart';

class AuthNotifier2 extends AsyncNotifier<AuthState> {
  @override
  FutureOr<AuthState> build() async {
    ref.read(authRepositoryProvider).listenChanges().listen((event) async {
      if (state.value?.user == null && event.auth?.uid.isNotEmpty == true) {
        final userResult = await ref
            .read(userRepositoryProvider)
            .getUser(uid: event.auth!.uid);

        userResult.ifSuccess((data) {
          state = AsyncData(AuthState(user: data, status: event.status));
        });
      } else if (event.status.isSignIn && event.auth == null) {
        state = AsyncData(AuthState(user: null, status: event.status));
      }
    });

    return AuthState();
  }
}
