import 'package:equatable/equatable.dart';

class UserRemoteEntity extends Equatable {
  const UserRemoteEntity({
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

  factory UserRemoteEntity.fromJson({
    required String uid,
    required Map<String, dynamic> json,
  }) => UserRemoteEntity(
    uid: uid,
    email: json['email'],
    username: json['username'],
    firebaseToken: json['firebaseToken'],
    locale: json['locale'],
  );

  Map<String, dynamic> toJson() => {
    'email': email,
    'username': username,
    'firebaseToken': firebaseToken,
    'locale': locale,
  };

  @override
  List<Object?> get props => [uid, email, username, firebaseToken, locale];
}
