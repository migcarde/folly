import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

class AuthEntity extends Equatable {
  const AuthEntity({required this.uid, required this.email});

  final String uid;
  final String email;

  @override
  List<Object?> get props => [uid, email];
}

extension AuthRemoteEntityExtensions on AuthRemoteEntity {
  AuthEntity get entity => AuthEntity(uid: uid, email: email);
}
