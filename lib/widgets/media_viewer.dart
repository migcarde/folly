import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folly/enums/asset_type.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/services/media_service.dart';
import 'package:folly/widgets/base_video_player.dart';

class MediaViewer extends StatelessWidget {
  const MediaViewer._({
    required this.filePath,
    this.maxHeight = 320.0,
    required this.assetType,
  });

  final String filePath;
  final double maxHeight;
  final AssetType assetType;

  factory MediaViewer.fromFilePath({
    required String filePath,
    double maxHeight = 320.0,
  }) {
    return MediaViewer._(
      filePath: filePath,
      maxHeight: maxHeight,
      assetType: AssetType.filePath,
    );
  }

  factory MediaViewer.fromUrl({required String url, double maxHeight = 320.0}) {
    return MediaViewer._(
      filePath: url,
      maxHeight: maxHeight,
      assetType: AssetType.url,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final isVideo = MediaService.isVideo(filePath);

    return Stack(
      children: [
        Container(
          constraints: BoxConstraints(
            maxHeight: maxHeight,
            maxWidth: double.infinity,
          ),
          color: theme.colorScheme.onSurfaceVariant,
          child: Align(
            alignment: Alignment.center,
            child: switch (assetType) {
              AssetType.url =>
                isVideo
                    ? Container(
                        constraints: BoxConstraints(maxHeight: maxHeight),
                        child: BaseVideoPlayer(
                          path: filePath,
                          assetType: assetType,
                        ),
                      )
                    : Image.network(filePath, height: maxHeight),
              AssetType.filePath =>
                isVideo
                    ? BaseVideoPlayer(path: filePath, assetType: assetType)
                    : Image.file(File(filePath), height: maxHeight),
            },
          ),
        ),
      ],
    );
  }
}
