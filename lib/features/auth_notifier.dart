import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends ChangeNotifier {
  UserEntity? user;
  final AuthListener authListener;
  final GetUser getUser;
  final ChallengesRepository challengesRepository;

  AuthNotifier({
    this.user,
    required this.authListener,
    required this.getUser,
    required this.challengesRepository,
  });

  void listen() async {
    authListener().listen((event) async {
      if (user == null && event != null && event.uid.isNotEmpty) {
        final userResult = await getUser(event.uid);

        userResult.ifSuccess((data) {
          user = data;
          notifyListeners();
        });
      } else if (user != null && event == null) {
        user = null;
        notifyListeners();
      }
    });
  }

  Future<void> update() async {
    if (user != null) {
      final userResult = await getUser(user!.uid);

      userResult.ifSuccess((data) {
        user = data;
      });
    }
  }
}

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthNotifier>(
  (ref) => AuthNotifier(
    authListener: ref.watch(authListenerProvider),
    getUser: ref.watch(getUserProvider),
    challengesRepository: ref.watch(challengeRepositoryProvider),
  ),
);
