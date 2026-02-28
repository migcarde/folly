import 'package:data/remote/auth/models/auth_remote_exception.dart';

enum AuthException {
  invalidEmail,
  emailAlreadyInUse,
  invalidCredentials,
  userBanned,
  userNotFound,
  weakPassword,
  sessionMissing,
  unknown;

  factory AuthException.fromRemoteException({
    required AuthRemoteException exception,
  }) {
    switch (exception) {
      case AuthRemoteException.invalidEmail:
        return AuthException.invalidEmail;
      case AuthRemoteException.emailAlreadyInUse:
      case AuthRemoteException.userAlreadyExists:
        return AuthException.emailAlreadyInUse;
      case AuthRemoteException.invalidCredentials:
        return AuthException.invalidCredentials;
      case AuthRemoteException.userBanned:
        return AuthException.userBanned;
      case AuthRemoteException.userNotFound:
        return AuthException.userNotFound;
      case AuthRemoteException.weakPassword:
        return AuthException.weakPassword;
      case AuthRemoteException.sessionMissing:
        return AuthException.sessionMissing;
      case AuthRemoteException.unknown:
        return AuthException.unknown;
    }
  }
}
