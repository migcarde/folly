import 'package:domain/auth/auth_repository.dart';
import 'package:domain/auth/enums/auth_event_status.dart';
import 'package:domain/domain.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends ChangeNotifier {
  AuthEventStatus status;
  UserEntity? user;
  bool isLoading = true;
  final AuthRepository authRepository;
  final UserRepository userRepository;
  final ChallengesRepository challengesRepository;

  AuthNotifier({
    this.status = AuthEventStatus.none,
    this.user,
    required this.authRepository,
    required this.userRepository,
    required this.challengesRepository,
  });

  Future<void> listen() async {
    authRepository.listenChanges().listen((event) async {
      status = event.status;
      if (user == null && event.auth != null && event.auth!.uid.isNotEmpty) {
        final userResult = await userRepository.getUser(uid: event.auth!.uid);

        userResult.ifSuccess((data) {
          isLoading = false;
          user = data;
          notifyListeners();
        });
      } else if (user != null && event.auth == null) {
        user = null;
        notifyListeners();
      } else if (user == null && event.auth == null) {
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
