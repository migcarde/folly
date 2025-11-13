import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/upload_story/models/upload_story_state.dart';
import 'package:folly/features/upload_story/upload_story_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/text_field/text_field_type.dart';
import 'package:image_picker/image_picker.dart';

class UploadStoryMobileLayout extends ConsumerWidget {
  UploadStoryMobileLayout({super.key, required this.file});

  final XFile file;
  final titleController = TextEditingController();

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
              SizedBox(
                width: double.infinity,
                height: 200.0,
                child: Image.file(File(file.path)),
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
