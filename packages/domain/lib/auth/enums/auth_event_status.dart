import 'package:data/remote/auth/enums/auth_remote_event_status.dart';

enum AuthEventStatus {
  none,
  signIn,
  signOut,
  passwordRecovery;

  bool get isNone => this == AuthEventStatus.none;
  bool get isSignIn => this == AuthEventStatus.signIn;
  bool get isSignOut => this == AuthEventStatus.signOut;
  bool get isPasswordRecovery => this == AuthEventStatus.passwordRecovery;
}

extension AuthRemoteEventStatusExtensions on AuthRemoteEventStatus {
  AuthEventStatus get eventStatus {
    switch (this) {
      case AuthRemoteEventStatus.signIn:
        return AuthEventStatus.signIn;
      case AuthRemoteEventStatus.signOut:
        return AuthEventStatus.signOut;
      case AuthRemoteEventStatus.passwordRecovery:
        return AuthEventStatus.passwordRecovery;
      default:
        return AuthEventStatus.none;
    }
  }
}
