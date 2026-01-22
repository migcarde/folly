import 'package:data/remote/auth/models/auth_remote_entity.dart';
import 'package:data/remote/auth/models/auth_remote_event.dart';

abstract class AuthRemoteDatasource {
  Future<AuthRemoteEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<void> logout();
  Future<AuthRemoteEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  });
  Stream<AuthRemoteEvent> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<void> deleteAccount();
  Future<void> reauthenticate({
    required String email,
    required String password,
  });
  Future<void> sendPasswordResetEmail({required String email});
  Future<void> updatePassword({required String password});
}
