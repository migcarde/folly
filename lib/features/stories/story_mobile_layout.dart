import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/comments/comments_mobile_layout.dart';
import 'package:folly/features/stories/story_notifier.dart';
import 'package:folly/features/story_card/story_card.dart';

class StoryMobileLayout extends ConsumerWidget {
  const StoryMobileLayout({super.key, required this.storyId});

  final String storyId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(storyProvider(storyId));

    return state.when(
      data: (data) => Column(
        children: [
          StoryCard(
            userId: data.story.user.uid,
            storyId: storyId,
            user: data.story.user.name,
            userProfileUrl: data.story.user.photoPath,
            title: data.story.title,
            mediaUrl: data.story.imageUrl,
            challenge: data.story.challenge,
          ),
          Expanded(
            child: CommentsMobileLayout(
              storyId: storyId,
              userStoryId: data.story.user.uid,
              isExpanded: true,
            ),
          ),
        ],
      ),
      error: (e, stackTrace) => const SizedBox(),
      loading: () => const SizedBox(),
    );
  }
}
