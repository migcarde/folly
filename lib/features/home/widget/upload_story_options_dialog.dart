import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/services/media_service.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/base_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class UploadStoryOptionsDialog extends StatelessWidget {
  const UploadStoryOptionsDialog._({required this.parentContext});

  final BuildContext parentContext;

  static const _iconSize = 42.0;

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
    final l10n = parentContext.l10n;
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppDimens.screenPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () async {
                final image = await MediaService.openCamera();

                if (context.mounted && image != null) {
                  context.pop();
                  parentContext.push(Paths.uploadStory.route, extra: image);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(PhosphorIcons.camera(), size: _iconSize),
                  Text(l10n.camera),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final image = await MediaService.openVideo();

                if (context.mounted && image != null) {
                  context.pop();
                  parentContext.push(Paths.uploadStory.route, extra: image);
                }
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(PhosphorIcons.videoCamera(), size: _iconSize),
                  Text(l10n.camera),
                ],
              ),
            ),
            GestureDetector(
              onTap: () async {
                final result = await MediaService.openGallery();

                result.when(
                  (image) {
                    if (context.mounted) {
                      context.pop();
                      parentContext.push(Paths.uploadStory.route, extra: image);
                    }
                  },
                  (error) {
                    if (error is MediaErrors) {
                      switch (error) {
                        case MediaErrors.noFileSelected:
                          break;
                        case MediaErrors.invalidImageExtension:
                          showDialog(
                            context: context,
                            builder: (context) => BaseDialog(
                              parentContext: context,
                              title: l10n.invalid_file_type,
                              body:
                                  '${l10n.please_use_one_of_these}: ${MediaService.supportedImageExtensions.join(', ')}',
                              confirmButtonText: l10n.accept,
                              cancelButtonText: l10n.cancel,
                              onTapConfirm: () {
                                context.pop();
                                MediaService.openGallery();
                              },
                              onTapCancel: () => context.pop(),
                            ),
                          );
                        case MediaErrors.invalidVideoExtension:
                          showDialog(
                            context: context,
                            builder: (context) => BaseDialog(
                              parentContext: context,
                              title: l10n.invalid_file_type,
                              body:
                                  '${l10n.please_use_one_of_these}: ${MediaService.supportedVideoExtensions.join(', ')}',

                              confirmButtonText: l10n.accept,
                              cancelButtonText: l10n.cancel,
                              onTapConfirm: () {
                                context.pop();
                                MediaService.openGallery();
                              },
                              onTapCancel: () => context.pop(),
                            ),
                          );
                      }
                    }
                  },
                );
              },
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(PhosphorIcons.image(), size: _iconSize),
                  Text(l10n.gallery),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
