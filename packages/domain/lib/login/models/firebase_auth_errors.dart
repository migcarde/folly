enum FirebaseAuthErrors {
  emailAlreadyInUse,
  invalidPassword,
  userNotFound,
  invalidCredetentials,
  unknown;

  factory FirebaseAuthErrors.fromString(String exception) {
    switch (exception) {
      case 'email-already-exists':
      case 'email-already-in-use':
        return FirebaseAuthErrors.emailAlreadyInUse;
      case 'invalid-password':
        return FirebaseAuthErrors.invalidPassword;
      case 'user-not-found':
        return FirebaseAuthErrors.userNotFound;
      case 'invalid-credential':
        return FirebaseAuthErrors.invalidCredetentials;
      default:
        return FirebaseAuthErrors.unknown;
    }
  }
}
