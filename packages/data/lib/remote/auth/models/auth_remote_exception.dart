enum AuthRemoteException {
  invalidEmail,
  emailAlreadyInUse,
  invalidCredentials,
  userBanned,
  userNotFound,
  weakPassword,
  sessionMissing,
  unknown;

  factory AuthRemoteException.fromString({required String exception}) {
    switch (exception) {
      case 'email_address_invalid':
        return AuthRemoteException.invalidEmail;
      case 'email_exists':
        return AuthRemoteException.emailAlreadyInUse;
      case 'invalid_credentials':
        return AuthRemoteException.invalidCredentials;
      case 'user_banned':
        return AuthRemoteException.userBanned;
      case 'user_not_found':
        return AuthRemoteException.userNotFound;
      case 'weak_password':
        return AuthRemoteException.weakPassword;
      case 'session_missing':
        return AuthRemoteException.sessionMissing;
      default:
        return AuthRemoteException.unknown;
    }
  }
}
