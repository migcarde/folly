import 'package:domain/friends/enums/friend_request_state.dart';
import 'package:domain/friends/models/friend_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/profile/profile_notifier.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/button_size.dart';
import 'package:folly/widgets/button/button_type.dart';

class RequestInformation extends ConsumerWidget {
  const RequestInformation({
    super.key,
    required this.uid,
    required this.friendRequest,
  });

  final String uid;
  final FriendEntity? friendRequest;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    switch (friendRequest?.state) {
      case FriendRequestState.friend:
      case FriendRequestState.following:
        return const SizedBox();
      case FriendRequestState.requested:
        return Padding(
          padding: const EdgeInsets.only(
            top: AppDimens.m,
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseButton(
                text: l10n.accept,
                size: ButtonSize.small,
                onTap: () =>
                    ref.read(profileNotifierProvider.notifier).acceptRequest(),
              ),
              BaseButton(
                text: l10n.decline,
                size: ButtonSize.small,
                type: ButtonType.alternative,
                onTap: () =>
                    ref.read(profileNotifierProvider.notifier).rejectRequest(),
              ),
            ],
          ),
        );
      case FriendRequestState.none:
      case null:
        return Padding(
          padding: const EdgeInsets.only(
            top: AppDimens.m,
            left: AppDimens.screenPadding,
            right: AppDimens.screenPadding,
          ),
          child: BaseButton(
            text: l10n.follow,
            size: ButtonSize.small,
            onTap: () => ref
                .read(profileNotifierProvider.notifier)
                .sendRequest(receiverId: uid),
          ),
        );
    }
  }
}
