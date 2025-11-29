import 'package:data/remote/auth/models/auth_remote_exception.dart';
import 'package:data/remote/auth/auth_remote_datasource.dart';
import 'package:data/remote/auth/models/auth_remote_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  @override
  Future<AuthRemoteEntity> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _supabase.client.auth.signInWithPassword(
        email: email,
        password: password,
      );

      return result.user!.remoteEntity;
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
    }
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
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
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
    try {
      final id = _supabase.client.auth.currentSession?.user.id;

      if (id != null) {
        await _supabase.client.auth.admin.deleteUser(id);
      }
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
    }
  }

  @override
  Future<void> reauthenticate({
    required String email,
    required String password,
  }) async {
    try {
      await _supabase.client.auth.reauthenticate();
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
    }
  }

  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _supabase.client.auth.resetPasswordForEmail(email);
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
    }
  }

  @override
  Future<void> updatePassword({required String password}) async {
    try {
      await _supabase.client.auth.updateUser(
        UserAttributes(password: password),
      );
    } on AuthApiException catch (exception) {
      throw AuthRemoteException.fromString(exception: exception.code ?? '');
    } catch (e) {
      throw AuthRemoteException.unknown;
    }
  }
}
