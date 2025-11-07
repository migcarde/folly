import 'package:data/data.dart';
import 'package:equatable/equatable.dart';

class FirebaseUserEntity extends Equatable {
  const FirebaseUserEntity({required this.uid, required this.email});

  final String uid;
  final String email;

  @override
  List<Object?> get props => [uid, email];
}

extension FirebaseUserRemoteEntityExtensions on FirebaseUserRemoteEntity {
  FirebaseUserEntity get entity => FirebaseUserEntity(uid: uid, email: email);
}

extension UserExtension on User {
  FirebaseUserEntity get entity =>
      FirebaseUserEntity(uid: uid, email: email ?? '');
}
