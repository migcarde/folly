import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/edit_profile/edit_profile_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/base_dialog.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:folly/widgets/editable_profile_image.dart';
import 'package:folly/widgets/photo_dialog.dart';
import 'package:folly/widgets/text_field/base_text_field.dart';
import 'package:go_router/go_router.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EditProfileMobileLayout extends ConsumerStatefulWidget {
  const EditProfileMobileLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _EditProfileMobileLayoutState();
}

class _EditProfileMobileLayoutState
    extends ConsumerState<EditProfileMobileLayout> {
  final _nameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();
  final _biographyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(editProfileProvider.notifier).init();

      final user = ref.watch(editProfileProvider).user;

      if (user != null) {
        _nameController.text = user.name;
        _biographyController.text = user.biography;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = context.theme;
    final state = ref.watch(editProfileProvider);

    ref.listen(editProfileProvider, (previous, next) {
      if (next.status.isError) {
        context.showSnackBar(
          message: l10n.sorry_we_have_problems_please_try_again_later,
          type: AppSnackbarType.negative,
        );
        ref.read(editProfileProvider.notifier).reset();
      } else if (next.status.isSendPasswordResetEmail) {
        context.showSnackBar(
          message: l10n.password_reset_email_send,
          type: AppSnackbarType.positive,
        );
        ref.read(editProfileProvider.notifier).reset();
      } else if (next.status.isSuccess) {
        context.showSnackBar(
          message: l10n.profile_updated,
          type: AppSnackbarType.positive,
        );
        context.pop();
      }
    });

    return state.status.isLoading
        ? const Center(child: CircularProgressIndicator())
        : Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    if (state.file == null)
                      EditableProfileImage.fromUrl(
                        onTap: () => PhotoDialog.show(
                          context: context,
                          selectedFile: (file) => ref
                              .read(editProfileProvider.notifier)
                              .loadPhoto(file: file),
                        ),
                        url: state.user?.photoPath ?? '',
                      ),
                    if (state.file != null)
                      EditableProfileImage.fromFile(
                        onTap: () => PhotoDialog.show(
                          context: context,
                          selectedFile: (file) => ref
                              .read(editProfileProvider.notifier)
                              .loadPhoto(file: file),
                        ),
                        file: state.file!,
                      ),

                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.l),
                      child: BaseTextField(
                        hint: l10n.name,
                        controller: _nameController,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.m),
                      child: BaseTextField(
                        hint: l10n.password,
                        controller: _passwordController,
                        textType: BaseTextFieldType.password,
                        errorText: state.error.getText(l10n: l10n),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.m),
                      child: BaseTextField(
                        hint: l10n.repeat_password,
                        controller: _passwordConfirmationController,
                        textType: BaseTextFieldType.password,
                        errorText: state.error.getText(l10n: l10n),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: AppDimens.m),
                      child: BaseTextField(
                        hint: l10n.tell_something_about_you,
                        controller: _biographyController,
                        textType: BaseTextFieldType.textArea,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: AppDimens.m,
                        bottom: AppDimens.xl,
                      ),
                      child: GestureDetector(
                        onTap: () => showDialog(
                          context: context,
                          builder: (dialogContext) => BaseDialog(
                            parentContext: context,
                            title: l10n.are_you_sure,
                            cancelButtonText: l10n.cancel,
                            onTapCancel: () => dialogContext.pop(),
                            confirmButtonText: l10n.delete,
                            onTapConfirm: () async {
                              dialogContext.pop();
                              context.loaderOverlay.show();

                              await ref
                                  .read(editProfileProvider.notifier)
                                  .deleteAccount();

                              if (context.mounted) {
                                context.loaderOverlay.hide();
                              }
                            },
                            body: l10n
                                .all_data_related_to_this_account_will_be_deleted_and_cannot_be_recovered,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              PhosphorIcons.trash(),
                              color: theme.colorScheme.error,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: AppDimens.s),
                              child: Text(
                                l10n.delete_account,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: theme.colorScheme.error,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: LoadingButton(
                  text: l10n.save,
                  isLoading: state.status.isUploadingProfile,
                  onTap: () => ref
                      .read(editProfileProvider.notifier)
                      .updateUser(
                        name: _nameController.text.isEmpty
                            ? null
                            : _nameController.text,
                        biography: _biographyController.text.isEmpty
                            ? null
                            : _biographyController.text,
                        file: state.file,
                        password: _passwordController.text.isEmpty
                            ? null
                            : _passwordController.text,
                        repeatPassword:
                            _passwordConfirmationController.text.isEmpty
                            ? null
                            : _passwordConfirmationController.text,
                      ),
                ),
              ),
            ],
          );
  }
}
