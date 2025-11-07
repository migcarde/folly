import 'package:data/remote/login/models/firebase_user_remote_entity.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class LoginRemoteDatasource {
  Future<FirebaseUserRemoteEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<FirebaseUserRemoteEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<User?> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<void> deleteAccount();
  Future<void> reauthenticate({
    required String email,
    required String password,
  });
}
