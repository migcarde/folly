import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/features/daily_challenge/daily_challenge_mobile_layout.dart';
import 'package:folly/features/home/widget/upload_story_options_dialog.dart';
import 'package:folly/widgets/base_scaffold.dart';
import 'package:folly/widgets/button/base_button.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return BaseScaffold(
      child: Column(
        children: [
          DailyChallengeMobileLayout(),
          BaseButton(
            text: 'text',
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (dialogContext) =>
                    UploadStoryOptionsDialog(parentContext: context),
              );
            },
          ),
        ],
      ),
    );
  }
}
