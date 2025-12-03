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
    required this.friends,
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String biography;
  final String firebaseToken;
  final String locale;
  final String photoPath;
  final List<String> friends;

  UserRemoteEntity get remoteEntity => UserRemoteEntity(
    uid: uid,
    name: name,
    email: email,
    username: username,
    biography: biography,
    token: firebaseToken,
    locale: locale,
    photoPath: photoPath,
    friends: friends,
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
    friends,
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
    List<String>? friends,
  }) => UserEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    biography: biography ?? this.biography,
    firebaseToken: firebaseToken ?? this.firebaseToken,
    locale: locale ?? this.locale,
    photoPath: photoPath ?? this.photoPath,
    friends: friends ?? this.friends,
  );

  UserEntity addFriend(String friend) =>
      copyWith(friends: [...friends, friend]);
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
    friends: friends,
  );
}
