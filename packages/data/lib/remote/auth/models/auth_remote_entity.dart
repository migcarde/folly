import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRemoteEntity extends Equatable {
  const AuthRemoteEntity({required this.uid, required this.email});

  final String uid;
  final String email;

  @override
  List<Object?> get props => [uid, email];
}

extension LoggedUserRemoteEntityExtensions on User {
  AuthRemoteEntity get remoteEntity =>
      AuthRemoteEntity(uid: id, email: email ?? '');
}
