import 'package:data/remote/login/models/auth_remote_entity.dart';

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
  Stream<AuthRemoteEntity?> listenChanges();
  bool get isLoggedIn;
  String get uid;
  Future<void> deleteAccount();
  Future<void> reauthenticate({
    required String email,
    required String password,
  });
}
