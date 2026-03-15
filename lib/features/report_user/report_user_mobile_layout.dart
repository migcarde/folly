import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/report_user/models/report_user_state.dart';
import 'package:folly/features/report_user/report_user_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/base_confirmation_bottom_dialog.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/button_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:folly/widgets/upload_media_dialog.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReportUserMobileLayout extends ConsumerStatefulWidget {
  const ReportUserMobileLayout({super.key, required this.uid});

  final String uid;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ReportUserMobileLayoutState();
}

class _ReportUserMobileLayoutState
    extends ConsumerState<ReportUserMobileLayout> {
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = context.theme;
    final l10n = context.l10n;

    final state = ref.watch(reportUserNotifierProvider);

    ref.listen(reportUserNotifierProvider, (previous, next) {
      if (next.value?.status.isSuccess ?? false) {
        context.showSnackBar(
          message: l10n.report_sent_successfully,
          type: AppSnackbarType.positive,
        );
        context.pop();
      } else if (next.value?.status.isFailure ?? false) {
        context.showSnackBar(
          message: l10n.oops_something_went_wrong,
          type: AppSnackbarType.negative,
        );
      }
    });

    return Column(
      children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              BaseTextField(
                controller: _descriptionController,
                hint: l10n.describe_what_happend,
                textType: BaseTextFieldType.textArea,
                errorText:
                    state.value?.errors.contains(
                          ReportUserError.descriptionEmpty,
                        ) ??
                        false
                    ? l10n.required_field
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: Text(
                  l10n.please_add_a_screenshot_or_a_video_of_the_reason_why_you_have_reported_this_user,
                ),
              ),
              if (state.value?.media == null) ...[
                Padding(
                  padding: const EdgeInsets.only(top: AppDimens.m),
                  child: BaseButton(
                    text: l10n.upload_file,
                    type: ButtonType.alternative,
                    leftIcon: PhosphorIcons.file(),
                    onTap: () => showModalBottomSheet(
                      context: context,
                      builder: (modalContext) {
                        return UploadMediaDialog(
                          parentContext: context,
                          onSuccess: (media) {
                            ref
                                .read(reportUserNotifierProvider.notifier)
                                .pickMedia(media: media);
                          },
                        );
                      },
                    ),
                  ),
                ),
                if (state.value?.errors.contains(ReportUserError.mediaEmpty) ??
                    false)
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimens.xs,
                        left: AppDimens.m,
                      ),
                      child: Text(
                        l10n.required_field,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
              ],
              if (state.value?.media != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(top: AppDimens.m),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.only(left: AppDimens.s),
                            child: Text(
                              state.value?.media?.name ?? '',
                              maxLines: 1,
                              style: theme.textTheme.bodyLarge?.copyWith(
                                color: theme.primaryColor,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => ref
                              .read(reportUserNotifierProvider.notifier)
                              .removeMedia(),
                          child: Icon(
                            PhosphorIcons.trash(),
                            color: theme.colorScheme.error,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
        LoadingButton(
          text: l10n.report,
          isLoading: state.isLoading,
          onTap: () {
            final reportUserNotifier = ref.read(
              reportUserNotifierProvider.notifier,
            );

            final hasErrors = reportUserNotifier.checkErrors(
              description: _descriptionController.text,
            );

            if (!hasErrors) {
              showModalBottomSheet(
                context: context,
                builder: (bottomSheetContext) => BaseConfirmationBottomDialog(
                  parentContext: context,
                  title: l10n.are_you_sure,
                  text: l10n.this_action_cannot_be_undone,
                  onTapConfirm: () => reportUserNotifier.send(
                    reportedUserId: widget.uid,
                    description: _descriptionController.text,
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
