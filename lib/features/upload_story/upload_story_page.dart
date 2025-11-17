import 'package:flutter/material.dart';
import 'package:folly/features/upload_story/upload_story_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';
import 'package:image_picker/image_picker.dart';

class UploadStoryPage extends StatelessWidget {
  const UploadStoryPage({super.key, required this.file});

  final XFile file;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(
      canGoBack: true,
      child: UploadStoryMobileLayout(file: file),
    );
  }
}
