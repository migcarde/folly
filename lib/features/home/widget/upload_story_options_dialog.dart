import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/upload_media_dialog.dart';
import 'package:go_router/go_router.dart';

class UploadStoryOptionsDialog extends StatelessWidget {
  const UploadStoryOptionsDialog._({required this.parentContext});

  final BuildContext parentContext;

  static void checkAvailability({
    required BuildContext context,
    required bool isCompleted,
  }) {
    if (isCompleted) {
      context.showSnackBar(
        message: context.l10n.cannot_post_story_after_challenge_completed,
        type: AppSnackbarType.negative,
      );
    } else {
      showModalBottomSheet(
        context: context,
        builder: (modalContext) =>
            UploadStoryOptionsDialog._(parentContext: context),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return UploadMediaDialog(
      parentContext: parentContext,
      onSuccess: (media) {
        parentContext.pushNamed(Paths.uploadStory.name, extra: media);
      },
    );
  }
}
