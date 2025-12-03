import 'package:equatable/equatable.dart';

class UserRemoteEntity extends Equatable {
  const UserRemoteEntity({
    required this.uid,
    required this.email,
    required this.name,
    required this.username,
    required this.biography,
    required this.token,
    required this.locale,
    required this.photoPath,
    required this.friends,
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String biography;
  final String token;
  final String locale;
  final String? photoPath;
  final List<String> friends;

  factory UserRemoteEntity.fromJson({required Map<String, dynamic> json}) =>
      UserRemoteEntity(
        uid: json['id'],
        name: json['display_name'],
        email: json['email'],
        username: json['username'],
        biography: json['biography'],
        token: json['token'],
        locale: json['locale'],
        photoPath: json['photo_path'],
        friends: (json['friends'] as List<String>?) ?? [],
      );

  Map<String, dynamic> toJson() => {
    'id': uid,
    'email': email,
    'display_name': name,
    'username': username,
    'biography': biography,
    'token': token,
    'locale': locale,
    'photo_path': photoPath,
    'friends': friends,
  };

  @override
  List<Object?> get props => [
    uid,
    name,
    email,
    username,
    biography,
    token,
    locale,
    photoPath,
    friends,
  ];

  UserRemoteEntity copyWith({
    String? uid,
    String? name,
    String? email,
    String? username,
    String? biography,
    String? token,
    String? locale,
    String? photoPath,
    List<String>? friends,
  }) => UserRemoteEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    biography: biography ?? this.biography,
    token: token ?? this.token,
    locale: locale ?? this.locale,
    photoPath: photoPath ?? this.photoPath,
    friends: friends ?? this.friends,
  );
}
