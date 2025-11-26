import 'package:domain/domain.dart';
import 'package:domain/login/auth_repository.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends ChangeNotifier {
  UserEntity? user;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ChallengesRepository challengesRepository;

  AuthNotifier({
    this.user,
    required this.authRepository,
    required this.userRepository,
    required this.challengesRepository,
  });

  Future<void> listen() async {
    authRepository.listenChanges().listen((event) async {
      if (user == null && event != null && event.uid.isNotEmpty) {
        final userResult = await userRepository.getUser(uid: event.uid);

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
      final userResult = await userRepository.getUser(uid: user!.uid);

      userResult.ifSuccess((data) {
        user = data;
      });
    }
  }

  Future<void> logout() async => await authRepository.logout();
}

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthNotifier>(
  (ref) => AuthNotifier(
    authRepository: ref.watch(loginRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
    challengesRepository: ref.watch(challengeRepositoryProvider),
  ),
);
