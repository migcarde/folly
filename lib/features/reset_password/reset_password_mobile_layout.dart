import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/reset_password/enums/reset_password_status.dart';
import 'package:folly/features/reset_password/reset_password_notifier.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordMobileLayout extends ConsumerStatefulWidget {
  const ResetPasswordMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordMobileLayoutState();
}

class _ResetPasswordMobileLayoutState
    extends ConsumerState<ResetPasswordMobileLayout> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ResetPasswordStatus? error;
    final l10n = context.l10n;
    final state = ref.watch(resetPasswordNotifier);

    if (state.hasError) {
      error = state.error as ResetPasswordStatus;
    }

    ref.listen<AsyncValue<ResetPasswordStatus>>(resetPasswordNotifier, (
      previous,
      next,
    ) {
      if (next.value?.isSuccess == true) {
        context.showSnackBar(
          message: l10n.password_changed,
          type: AppSnackbarType.positive,
        );
        context.go(Paths.home.route);
      } else if (next.hasError) {
        if (error?.isUnknownError == true) {
          context.showSnackBar(
            message: l10n.sorry_we_have_problems_please_try_again_later,
            type: AppSnackbarType.negative,
          );
        }
      }
    });

    return Column(
      children: [
        BaseTextField(
          hint: l10n.password,
          controller: passwordController,
          textType: BaseTextFieldType.password,
          errorText: error == null || error == ResetPasswordStatus.unknownError
              ? null
              : error.getText(l10n: l10n),
        ),
        Padding(
          padding: const EdgeInsets.only(top: AppDimens.m),
          child: BaseTextField(
            hint: l10n.repeat_password,
            controller: confirmPasswordController,
            textType: BaseTextFieldType.password,
          ),
        ),
        const Spacer(),
        LoadingButton(
          text: l10n.save,
          isLoading: state.isLoading,
          onTap: () => ref
              .read(resetPasswordNotifier.notifier)
              .resetPassword(
                password: passwordController.text,
                repeatPassword: confirmPasswordController.text,
              ),
        ),
      ],
    );
  }
}
