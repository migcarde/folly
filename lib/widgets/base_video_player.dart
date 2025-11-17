import 'dart:io';

import 'package:flutter/material.dart';
import 'package:folly/enums/asset_type.dart';
import 'package:folly/widgets/playback_button.dart';
import 'package:video_player/video_player.dart';

class BaseVideoPlayer extends StatefulWidget {
  const BaseVideoPlayer({
    super.key,
    required this.path,
    required this.assetType,
  });

  final String path;
  final AssetType assetType;

  @override
  BaseVideoPlayerState createState() => BaseVideoPlayerState();
}

class BaseVideoPlayerState extends State<BaseVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    switch (widget.assetType) {
      case AssetType.url:
        _controller = VideoPlayerController.networkUrl(Uri.parse(widget.path));
      case AssetType.filePath:
        _controller = VideoPlayerController.file(File(widget.path));
    }

    _controller.initialize().then((_) {
      setState(() {});
      _controller.play();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Stack(
            children: [
              FittedBox(
                fit: BoxFit.fitHeight,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
              Positioned.fill(
                child: PlaybackButton(
                  onTap: () {
                    _controller.value.isPlaying
                        ? _controller.pause()
                        : _controller.play();
                  },
                ),
              ),
            ],
          )
        : SizedBox();
  }
}
