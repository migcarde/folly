import 'package:domain/domain.dart';
import 'package:domain/login/models/firebase_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends ChangeNotifier {
  FirebaseUserEntity? user;
  final AuthListener authListener;

  AuthNotifier({this.user, required this.authListener});

  void listen() async {
    authListener().listen((event) {
      if (user != event) {
        user = event;
        notifyListeners();
      }
    });
  }
}

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthNotifier>((
  ref,
) {
  return AuthNotifier(authListener: ref.watch(authListenerProvider));
});
