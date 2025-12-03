import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/profile/models/profile_state.dart';
import 'package:folly/features/profile/profile_notifier.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/button_size.dart';
import 'package:folly/widgets/button/button_type.dart';

class RequestInformation extends ConsumerWidget {
  const RequestInformation({
    super.key,
    required this.uid,
    required this.status,
  });

  final String uid;
  final RequestStatus status;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    switch (status) {
      case RequestStatus.friend:
        return const SizedBox();
      case RequestStatus.pending:
        return BaseButton(
          text: l10n.pending,
          size: ButtonSize.small,
          type: ButtonType.alternative,
          onTap: () {},
        );
      case RequestStatus.none:
        return BaseButton(
          text: l10n.follow,
          size: ButtonSize.small,
          onTap: () => ref
              .read(profileNotifierProvider.notifier)
              .sendRequest(receiverId: uid),
        );
    }
  }
}
