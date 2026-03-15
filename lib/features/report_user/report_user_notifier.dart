import 'dart:async';
import 'dart:io';

import 'package:domain/report_user/models/report_user_entity.dart';
import 'package:domain/report_user/report_user_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/report_user/models/report_user_state.dart';
import 'package:image_picker/image_picker.dart';

class ReportUserNotifier extends AsyncNotifier<ReportUserState> {
  @override
  FutureOr<ReportUserState> build() {
    return ReportUserState();
  }

  void pickMedia({required XFile media}) async =>
      state = AsyncData(ReportUserState(media: media));

  void removeMedia() => state = AsyncData(ReportUserState());

  Future<void> send({
    required String reportedUserId,
    required String description,
  }) async {
    final hasErrors = checkErrors(description: description);

    if (!hasErrors) {
      state = AsyncLoading();

      final result = await ref
          .read(reportUserRepositoryProvider)
          .reportUser(
            reportUser: ReportUserEntity(
              senderUserId: ref.read(authNotifierProvider).user!.uid,
              reportedUserId: reportedUserId,
              file: File(state.value!.media!.path),
              description: description,
            ),
          );

      result.when(
        (data) => state = AsyncData(
          state.value!.copyWith(status: ReportUserStaus.success),
        ),
        (error, stackTrace) => state = AsyncData(
          state.value!.copyWith(status: ReportUserStaus.failure),
        ),
      );
    }
  }

  bool checkErrors({required String description}) {
    final errors = [
      if (state.value?.media == null) ReportUserError.mediaEmpty,
      if (description.isEmpty) ReportUserError.descriptionEmpty,
    ];

    if (errors.isNotEmpty) {
      state = AsyncData(state.value!.copyWith(errors: errors));
    }

    return errors.isNotEmpty;
  }
}

final reportUserNotifierProvider =
    AsyncNotifierProvider.autoDispose<ReportUserNotifier, ReportUserState>(
      () => ReportUserNotifier(),
    );
