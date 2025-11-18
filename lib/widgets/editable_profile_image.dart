import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';

class EditableProfileImage extends StatelessWidget {
  const EditableProfileImage({super.key, required this.onTap, this.filePath});

  final VoidCallback onTap;
  final File? filePath;

  static const _imageSize = 120.0;
  static const _editContainerPadding = 6.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: _imageSize,
        height: _imageSize,
        decoration: BoxDecoration(
          color: theme.colorScheme.primaryContainer,
          borderRadius: BorderRadius.circular(AppDimens.circularRadius),
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: ClipOval(
                child: filePath != null
                    ? Image.file(
                        filePath!,
                        width: _imageSize,
                        height: _imageSize,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.person,
                        size: _imageSize * 0.6,
                        color: theme.primaryColor,
                      ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: const EdgeInsets.all(_editContainerPadding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.edit, color: theme.colorScheme.onPrimary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
