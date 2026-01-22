import 'package:supabase_flutter/supabase_flutter.dart';

enum AuthRemoteEventStatus { none, signIn, signOut, passwordRecovery }

extension AuthChangeEventExtensions on AuthChangeEvent {
  AuthRemoteEventStatus get remoteEventStatus {
    switch (this) {
      case AuthChangeEvent.signedIn:
        return AuthRemoteEventStatus.signIn;
      case AuthChangeEvent.signedOut:
        return AuthRemoteEventStatus.signOut;
      case AuthChangeEvent.passwordRecovery:
        return AuthRemoteEventStatus.passwordRecovery;
      default:
        return AuthRemoteEventStatus.none;
    }
  }
}
