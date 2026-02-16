import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/daily_challenge/daily_challenge_provider.dart';
import 'package:folly/features/feed/feed_notifier.dart';
import 'package:folly/features/profile/models/profile_params.dart';
import 'package:folly/features/profile/profile_notifier.dart';
import 'package:folly/features/upload_story/models/upload_story_state.dart';
import 'package:folly/features/upload_story/upload_story_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/media_viewer.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class UploadStoryMobileLayout extends ConsumerWidget {
  UploadStoryMobileLayout({super.key, required this.file});

  final XFile file;
  final titleController = TextEditingController();

  static const _mediaMaxHeight = 200.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = context.theme.textTheme;
    final state = ref.watch(uploadStoryProvider);

    ref.listen(uploadStoryProvider, (previous, next) {
      switch (next.status) {
        case UploadStoryStatus.initial:
        case UploadStoryStatus.loading:
          break;
        case UploadStoryStatus.success:
          context.showSnackBar(message: l10n.story_published);
          context.go(Paths.home.route);
          ref.read(feedNotifierProvider.notifier).init();
          ref.read(dailyChallengeNotifierProvider.notifier).init();
          ref
              .read(
                profileNotifierProvider(
                  ProfileParams(user: ref.watch(authNotifierProvider).user!),
                ).notifier,
              )
              .build();

          break;
        case UploadStoryStatus.error:
          context.showSnackBar(
            message: l10n.sorry_we_have_problems_please_try_again_later,
            type: AppSnackbarType.negative,
          );
          break;
      }
    });

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppDimens.xl),

          child: Column(
            children: [
              MediaViewer.fromFilePath(
                filePath: file.path,
                maxHeight: _mediaMaxHeight,
              ),

              GestureDetector(
                onTap: () =>
                    ref.read(uploadStoryProvider.notifier).hideErrors(),
                child: BaseTextField(
                  hint: l10n.title,
                  controller: titleController,
                  type: TextFieldType.none,
                  textType: BaseTextFieldType.textArea,
                  textStyle: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  errorText: state.titleIsEmpty ? l10n.required_field : null,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: AlignmentGeometry.bottomCenter,
          child: LoadingButton(
            text: l10n.save,
            isLoading: state.status.isLoading,
            onTap: () => ref
                .read(uploadStoryProvider.notifier)
                .uploadStory(file: file, title: titleController.text),
          ),
        ),
      ],
    );
  }
}
