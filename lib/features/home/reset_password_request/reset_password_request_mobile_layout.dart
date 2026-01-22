import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/home/reset_password_request/reset_password_request_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/base_button.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:go_router/go_router.dart';

class ResetPasswordRequestMobileLayout extends ConsumerStatefulWidget {
  const ResetPasswordRequestMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ResetPasswordRequestMobileLayoutState();
}

class _ResetPasswordRequestMobileLayoutState
    extends ConsumerState<ResetPasswordRequestMobileLayout> {
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = ref.watch(resetPasswordRequestNotifierProvider);

    ref.listen(resetPasswordRequestNotifierProvider, (previous, next) {
      if (next.value == true) {
        context.showSnackBar(
          message: l10n.password_reset_email_sent_check_your_inbox,
          type: AppSnackbarType.positive,
        );
        context.pop();
      } else if (next.hasError) {
        context.showSnackBar(
          message: context.l10n.sorry_we_have_problems_please_try_again_later,
          type: AppSnackbarType.negative,
        );
        context.pop();
      }
    });

    return state.when(
      data: (_) => Column(
        children: [
          BaseTextField(hint: l10n.email, controller: emailController),
          const Spacer(),
          BaseButton(
            text: l10n.send,
            onTap: () => ref
                .read(resetPasswordRequestNotifierProvider.notifier)
                .sendResetPasswordRequest(emailController.text),
          ),
        ],
      ),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stacktrace) => Column(
        children: [
          BaseTextField(hint: l10n.email, controller: emailController),
          const Spacer(),
          LoadingButton(
            text: l10n.send,
            isLoading: state.isLoading,
            onTap: () => ref
                .read(resetPasswordRequestNotifierProvider.notifier)
                .sendResetPasswordRequest(emailController.text),
          ),
        ],
      ),
    );
  }
}
