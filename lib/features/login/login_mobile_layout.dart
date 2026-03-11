import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/login/login_notifier.dart';
import 'package:folly/features/login/models/login_state.dart';
import 'package:folly/routes/paths.dart';
import 'package:folly/services/messaging/messaging_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/primary_link.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:go_router/go_router.dart';

class LoginMobileLayout extends ConsumerStatefulWidget {
  const LoginMobileLayout({super.key});

  @override
  ConsumerState<LoginMobileLayout> createState() =>
      _RegisterMobileLayoutState();
}

class _RegisterMobileLayoutState extends ConsumerState<LoginMobileLayout> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = ref.watch(loginNotifierProvider);
    ref.listen(loginNotifierProvider, (previous, next) {
      if (next.errors.contains(LoginError.unknown)) {
        context.showSnackBar(
          message: context.l10n.sorry_we_have_problems_please_try_again_later,
          type: AppSnackbarType.negative,
        );
      }
    });

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: AppDimens.l),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              BaseTextField(
                hint: l10n.email,
                controller: emailController,
                errorText: state.errors.hasEmailErrors
                    ? state.errors.getEmailErrorMessage(context)
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.password,
                  textType: BaseTextFieldType.password,
                  errorText: state.errors.contains(LoginError.passwordRequired)
                      ? LoginError.passwordRequired.getMessage(context)
                      : null,
                  controller: passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: PrimaryLink(
                  text: l10n.are_you_not_registered_question,
                  onTap: () => context.pushNamed(Paths.register.name),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: PrimaryLink(
                  text: l10n.does_not_remember_your_password,
                  onTap: () =>
                      context.pushNamed(Paths.resetPasswordRequest.name),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LoadingButton(
            text: l10n.login,
            isLoading: state.status.isLoading,
            onTap: () async {
              final firebaseToken = await ref
                  .read(messagingNotifierProvider.notifier)
                  .getToken();
              await ref
                  .read(loginNotifierProvider.notifier)
                  .login(
                    email: emailController.text,
                    password: passwordController.text,
                    firebaseToken: firebaseToken ?? '',
                  );
            },
          ),
        ),
      ],
    );
  }
}
