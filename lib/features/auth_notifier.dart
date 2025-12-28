import 'package:domain/auth/auth_repository.dart';
import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends ChangeNotifier {
  UserEntity? user;
  bool isLoading = true;
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
          isLoading = false;
          user = data;
          notifyListeners();
        });
      } else if (user != null && event == null) {
        user = null;
        notifyListeners();
      } else if (user == null && event == null) {
        isLoading = false;
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

  bool isCurrentUser({required String uid}) => user?.uid == uid;
}

final authNotifierProvider = ChangeNotifierProvider.autoDispose<AuthNotifier>(
  (ref) => AuthNotifier(
    authRepository: ref.watch(authRepositoryProvider),
    userRepository: ref.watch(userRepositoryProvider),
    challengesRepository: ref.watch(challengeRepositoryProvider),
  ),
);
