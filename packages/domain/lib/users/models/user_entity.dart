import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.username,
    required this.biography,
    required this.firebaseToken,
    required this.locale,
    required this.photoPath,
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String biography;
  final String firebaseToken;
  final String locale;
  final String photoPath;

  UserRemoteEntity get remoteEntity => UserRemoteEntity(
    uid: uid,
    name: name,
    email: email,
    username: username,
    biography: biography,
    token: firebaseToken,
    locale: locale,
    photoPath: photoPath,
  );

  @override
  List<Object?> get props => [
    uid,
    name,
    email,
    username,
    biography,
    firebaseToken,
    locale,
    photoPath,
  ];

  UserEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? username,
    String? biography,
    String? firebaseToken,
    String? locale,
    String? photoPath,
  }) => UserEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    biography: biography ?? this.biography,
    firebaseToken: firebaseToken ?? this.firebaseToken,
    locale: locale ?? this.locale,
    photoPath: photoPath ?? this.photoPath,
  );
}

extension UserRemoteEntityExtensions on UserRemoteEntity {
  UserEntity get entity => UserEntity(
    uid: uid,
    name: name,
    email: email,
    username: username,
    biography: biography,
    firebaseToken: token,
    locale: locale,
    photoPath: photoPath ?? '',
  );
}
