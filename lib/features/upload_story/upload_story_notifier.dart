import 'dart:io';

import 'package:domain/stories/stories_repository.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:folly/features/upload_story/models/upload_story_state.dart';
import 'package:image_picker/image_picker.dart';

class UploadStoryNotifier extends StateNotifier<UploadStoryState> {
  final StoriesRepository storiesRepository;

  UploadStoryNotifier({required this.storiesRepository})
    : super(const UploadStoryState());

  Future<void> uploadStory({required XFile file, required String title}) async {
    if (title.isEmpty) {
      state = state.copyWith(titleIsEmpty: true);
      return;
    }

    state = state.copyWith(status: UploadStoryStatus.loading);
    await storiesRepository.init();

    final result = await storiesRepository.uploadFile(file: File(file.path));

    result.when(
      (_) => state = state.copyWith(status: UploadStoryStatus.success),
      (_) => state = state.copyWith(status: UploadStoryStatus.error),
    );
  }

  void hideErrors() => state = state.copyWith(titleIsEmpty: false);
}

final uploadStoryProvider =
    StateNotifierProvider.autoDispose<UploadStoryNotifier, UploadStoryState>(
      (ref) => UploadStoryNotifier(
        storiesRepository: ref.watch(storiesRepositoryProvider),
      ),
    );
