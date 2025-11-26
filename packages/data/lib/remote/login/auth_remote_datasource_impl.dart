import 'package:data/remote/login/auth_remote_datasource.dart';
import 'package:data/remote/login/models/auth_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  @override
  Future<AuthRemoteEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final result = await _supabase.client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return result.user!.remoteEntity;
  }

  @override
  Future<void> logout() async => await _supabase.client.auth.signOut();

  @override
  Future<AuthRemoteEntity> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _supabase.client.auth.signUp(
        email: email,
        password: password,
      );

      return result.user!.remoteEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<AuthRemoteEntity?> listenChanges() async* {
    await for (final auth in _supabase.client.auth.onAuthStateChange) {
      yield auth.session?.user.remoteEntity;
    }
  }

  @override
  bool get isLoggedIn => _supabase.client.auth.currentSession != null;

  @override
  String get uid => _supabase.client.auth.currentSession?.user.id ?? '';

  @override
  Future<void> deleteAccount() async {
    final id = _supabase.client.auth.currentSession?.user.id;

    if (id != null) {
      await _supabase.client.auth.admin.deleteUser(id);
    }
  }

  @override
  Future<void> reauthenticate({
    required String email,
    required String password,
  }) async => await _supabase.client.auth.reauthenticate();

  @override
  Future<void> sendPasswordResetEmail({required String email}) async =>
      await _supabase.client.auth.resetPasswordForEmail(email);

  @override
  Future<void> updatePassword({required String password}) async =>
      await _supabase.client.auth.updateUser(
        UserAttributes(password: password),
      );
}
