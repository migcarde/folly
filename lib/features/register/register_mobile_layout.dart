import 'dart:io';

import 'package:domain/users/models/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/register/models/register_state.dart';
import 'package:folly/features/register/register_notifier.dart';
import 'package:folly/services/messaging/messaging_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/editable_profile_image.dart';
import 'package:folly/widgets/photo_dialog.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';

class RegisterMobileLayout extends ConsumerStatefulWidget {
  const RegisterMobileLayout({super.key});

  @override
  ConsumerState<RegisterMobileLayout> createState() =>
      _RegisterMobileLayoutState();
}

class _RegisterMobileLayoutState extends ConsumerState<RegisterMobileLayout> {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final repeatPasswordController = TextEditingController();
  final bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final state = ref.watch(registerNotifierProvider);

    ref.listen(registerNotifierProvider, (previous, next) {
      if (next.status.isError) {
        context.showSnackBar(
          message: context.l10n.sorry_we_have_problems_please_try_again_later,
          type: AppSnackbarType.negative,
        );
      }
    });

    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              EditableProfileImage.fromFile(
                onTap: () => PhotoDialog.show(
                  context: context,
                  selectedFile: (file) => ref
                      .read(registerNotifierProvider.notifier)
                      .loadPhoto(file: file),
                ),
                file: state.file,
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.l),
                child: BaseTextField(
                  hint: l10n.email,
                  controller: emailController,
                  errorText: state.errors.hasEmailErrors
                      ? state.errors.getEmailErrorMessage(context)
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.name,
                  controller: nameController,
                  errorText: state.errors.contains(RegisterError.nameEmpty)
                      ? l10n.name_is_required
                      : null,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.username.toLowerCase(),
                  errorText:
                      state.errors.contains(RegisterError.usernameAlreadyInUse)
                      ? l10n.username_already_in_use
                      : null,
                  controller: usernameController,
                  prefixText: '@',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.password,
                  textType: BaseTextFieldType.password,
                  errorText:
                      state.errors.contains(
                        RegisterError.passwordMustBeStronger,
                      )
                      ? l10n.passwords_is_weak
                      : null,
                  controller: passwordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.repeat_password,
                  textType: BaseTextFieldType.password,
                  errorText:
                      state.errors.contains(RegisterError.passwordNotMatch)
                      ? l10n.password_does_not_match
                      : null,
                  controller: repeatPasswordController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: AppDimens.m),
                child: BaseTextField(
                  hint: l10n.tell_something_about_you,
                  controller: bioController,
                  textType: BaseTextFieldType.textArea,
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: LoadingButton(
            text: l10n.register,
            isLoading: state.status.isLoading,
            onTap: () async {
              final firebaseToken = await ref
                  .read(messagingNotifierProvider.notifier)
                  .getToken();

              ref
                  .read(registerNotifierProvider.notifier)
                  .register(
                    user: UserEntity(
                      uid: '',
                      name: nameController.text,
                      email: emailController.text,
                      biography: bioController.text,
                      username: usernameController.text,
                      firebaseToken: firebaseToken ?? '',
                      locale: Platform.localeName,
                      photoPath: '',
                    ),
                    password: passwordController.text,
                    repeatPassword: repeatPasswordController.text,
                  );
            },
          ),
        ),
      ],
    );
  }
}
