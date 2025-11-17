import 'dart:io';

import 'package:domain/domain.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/upload_story/models/upload_story_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadStoryNotifier extends StateNotifier<UploadStoryState> {
  final StoriesRepository storiesRepository;
  final AuthNotifier authNotifier;
  final ChallengesRepository challengesRepository;

  UploadStoryNotifier({
    required this.storiesRepository,
    required this.authNotifier,
    required this.challengesRepository,
  }) : super(const UploadStoryState());

  Future<void> uploadStory({required XFile file, required String title}) async {
    if (title.isEmpty) {
      state = state.copyWith(titleIsEmpty: true);
      return;
    }

    state = state.copyWith(status: UploadStoryStatus.loading);

    final challengeResult = await challengesRepository.getUserChallenge(
      uid: authNotifier.user?.uid ?? '',
    );

    challengeResult.ifSuccess((challenge) async {
      final result = await storiesRepository.uploadFile(
        uid: authNotifier.user?.uid ?? '',
        title: title,
        file: File(file.path),
        challengeId: challenge?.id ?? '',
      );

      result.when(
        (_) => state = state.copyWith(status: UploadStoryStatus.success),
        (_) => state = state.copyWith(status: UploadStoryStatus.error),
      );
    });

    // TODO: Control if challenge is not available
  }

  void hideErrors() => state = state.copyWith(titleIsEmpty: false);
}

final uploadStoryProvider =
    StateNotifierProvider.autoDispose<UploadStoryNotifier, UploadStoryState>(
      (ref) => UploadStoryNotifier(
        storiesRepository: ref.watch(storiesRepositoryProvider),
        authNotifier: ref.watch(authNotifierProvider),
        challengesRepository: ref.watch(challengeRepositoryProvider),
      ),
    );
