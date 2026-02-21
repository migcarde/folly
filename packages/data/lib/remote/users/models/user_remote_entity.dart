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
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String biography;
  final String token;
  final String locale;
  final String? photoPath;

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
      );

  Map<String, dynamic> toJson() => {
    //! TODO: Something is wrong on JSON
    'id': uid.isNotEmpty ? uid : null,
    'email': email,
    'display_name': name,
    'username': username,
    'biography': biography,
    'token': token,
    'locale': locale,
    'photo_path': photoPath,
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
  }) => UserRemoteEntity(
    uid: uid ?? this.uid,
    name: name ?? this.name,
    email: email ?? this.email,
    username: username ?? this.username,
    biography: biography ?? this.biography,
    token: token ?? this.token,
    locale: locale ?? this.locale,
    photoPath: photoPath ?? this.photoPath,
  );
}
