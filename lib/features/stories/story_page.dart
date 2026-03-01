import 'package:flutter/material.dart';
import 'package:folly/features/stories/story_mobile_layout.dart';

class StoryPage extends StatelessWidget {
  const StoryPage({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: StoryMobileLayout(storyId: storyId)),
    );
  }
}
