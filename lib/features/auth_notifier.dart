import 'package:domain/base/result.dart';
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
        final results = await Future.wait([
          getUser(event.uid),
          challengesRepository.init(),
        ]);

        final userResult = results[0] as Result<UserEntity>;
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
}

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthNotifier>(
  (ref) => AuthNotifier(
    authListener: ref.watch(authListenerProvider),
    getUser: ref.watch(getUserProvider),
    challengesRepository: ref.watch(challengeRepositoryProvider),
  ),
);
