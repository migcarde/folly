import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.email,
    required this.username,
    required this.firebaseToken,
    required this.locale,
  });

  final String uid;
  final String email;
  final String username;
  final String firebaseToken;
  final String locale;

  UserRemoteEntity get remoteEntity => UserRemoteEntity(
    uid: uid,
    email: email,
    username: username,
    firebaseToken: firebaseToken,
    locale: locale,
  );

  @override
  List<Object?> get props => [uid, email, username, firebaseToken, locale];
}

extension UserRemoteEntityExtensions on UserRemoteEntity {
  UserEntity get entity => UserEntity(
    uid: uid,
    email: email,
    username: username,
    firebaseToken: firebaseToken,
    locale: locale,
  );
}
