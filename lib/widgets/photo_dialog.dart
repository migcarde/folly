import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/services/media_service.dart';
import 'package:folly/widgets/bottom_dialog_option.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PhotoDialog extends StatelessWidget {
  const PhotoDialog._({
    required this.parentContext,
    required this.selectedFile,
  });

  final BuildContext parentContext;
  final Function(File) selectedFile;

  static void show({
    required BuildContext context,
    required Function(File) selectedFile,
  }) {
    showModalBottomSheet(
      context: context,
      builder: (modalContext) =>
          PhotoDialog._(parentContext: context, selectedFile: selectedFile),
    );
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
            BottomDialogOption(
              icon: PhosphorIcons.camera(),
              label: l10n.camera,
              onTap: () async {
                final image = await MediaService.openCamera();

                if (context.mounted && image != null) {
                  context.pop();
                  selectedFile(File(image.path));
                }
              },
            ),
            BottomDialogOption(
              icon: PhosphorIcons.image(),
              label: l10n.gallery,
              onTap: () async {
                final image = await MediaService.openImageGallery();

                if (context.mounted && image != null) {
                  context.pop();
                  selectedFile(File(image.path));
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
