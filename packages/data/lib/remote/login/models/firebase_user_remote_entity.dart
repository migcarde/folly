import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseUserRemoteEntity extends Equatable {
  const FirebaseUserRemoteEntity({required this.uid, required this.email});

  final String uid;
  final String email;

  @override
  List<Object?> get props => [uid, email];
}

extension UserFromFirebaseExtensions on User {
  FirebaseUserRemoteEntity get firebaseUser =>
      FirebaseUserRemoteEntity(uid: uid, email: email ?? '');
}
