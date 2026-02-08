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
import 'package:folly/widgets/button/loading_button.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RequestInformation extends ConsumerStatefulWidget {
  const RequestInformation({
    super.key,
    required this.uid,
    required this.friendRequest,
  });

  final String uid;
  final FriendEntity? friendRequest;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _RequestInformationState();
}

class _RequestInformationState extends ConsumerState<RequestInformation> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    switch (widget.friendRequest?.state) {
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
            mainAxisAlignment: MainAxisAlignment.spaceAround,
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
          child: LoadingButton(
            text: l10n.follow,
            leftIcon: PhosphorIcons.userPlus(),
            isLoading: _isLoading,
            onTap: () async {
              setState(() {
                _isLoading = true;
              });

              await ref
                  .read(profileNotifierProvider.notifier)
                  .sendRequest(receiverId: widget.uid);

              setState(() {
                _isLoading = false;
              });
            },
          ),
        );
    }
  }
}
