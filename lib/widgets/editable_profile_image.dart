import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';

enum EditableProfileImageType { file, url }

class EditableProfileImage extends StatelessWidget {
  const EditableProfileImage._({
    required this.onTap,
    this.filePath,
    this.url,
    required this.type,
  });

  static fromFile({required VoidCallback onTap, required File? file}) =>
      EditableProfileImage._(
        onTap: onTap,
        filePath: file,
        type: EditableProfileImageType.file,
      );

  static fromUrl({required VoidCallback onTap, required String? url}) =>
      EditableProfileImage._(
        onTap: onTap,
        url: url,
        type: EditableProfileImageType.url,
      );

  final VoidCallback onTap;
  final File? filePath;
  final String? url;
  final EditableProfileImageType type;

  static const _imageSize = 120.0;
  static const _editContainerPadding = 6.0;

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    late Widget image;

    if (type == EditableProfileImageType.url &&
        url != null &&
        url!.isNotEmpty) {
      image = Image.network(
        url!,
        width: _imageSize,
        height: _imageSize,
        fit: BoxFit.cover,
      );
    } else if (type == EditableProfileImageType.file && filePath != null) {
      image = Image.file(
        filePath!,
        width: _imageSize,
        height: _imageSize,
        fit: BoxFit.cover,
      );
    } else {
      image = Icon(
        Icons.person,
        size: _imageSize * 0.6,
        color: theme.primaryColor,
      );
    }

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
              child: ClipOval(child: image),
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
