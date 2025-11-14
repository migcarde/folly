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
  });

  final String uid;
  final String name;
  final String email;
  final String username;
  final String biography;
  final String token;
  final String locale;

  factory UserRemoteEntity.fromJson({
    required String uid,
    required Map<String, dynamic> json,
  }) => UserRemoteEntity(
    uid: uid,
    name: json['display_name'],
    email: json['email'],
    username: json['username'],
    biography: json['biography'],
    token: json['token'],
    locale: json['locale'],
  );

  Map<String, dynamic> toJson() => {
    'id': uid,
    'email': email,
    'display_name': name,
    'username': username,
    'biography': biography,
    'token': token,
    'locale': locale,
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
  ];
}
