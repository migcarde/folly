import 'package:data/remote/login/login_remote_datasource.dart';
import 'package:data/remote/login/models/firebase_user_remote_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginRemoteDatasourceImpl implements LoginRemoteDatasource {
  final FirebaseAuth _instance = FirebaseAuth.instance;

  @override
  Future<FirebaseUserRemoteEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user!.firebaseUser;
  }

  @override
  Future<void> logout() async => await _instance.signOut();

  @override
  Future<FirebaseUserRemoteEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    return result.user!.firebaseUser;
  }

  @override
  Stream<User?> listenChanges() => _instance.userChanges();

  @override
  bool get isLoggedIn => _instance.currentUser != null;

  @override
  String get uid => _instance.currentUser?.uid ?? '';

  @override
  Future<void> deleteAccount() async => await _instance.currentUser?.delete();

  @override
  Future<void> reauthenticate({
    required String email,
    required String password,
  }) async => await _instance.currentUser?.reauthenticateWithCredential(
    EmailAuthProvider.credential(email: email, password: password),
  );
}
