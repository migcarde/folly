import 'package:flutter/material.dart';
import 'package:folly/features/stories/story_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: StoryMobileLayout(storyId: storyId));
  }
}
