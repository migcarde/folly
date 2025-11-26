import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/change_language/change_language_notifier.dart';
import 'package:folly/l10n/localization_notifier.dart';
import 'package:folly/widgets/app_snackbar_type.dart';
import 'package:folly/widgets/button/loading_button.dart';
import 'package:go_router/go_router.dart';

class ChangeLanguageMobileLayout extends ConsumerWidget {
  const ChangeLanguageMobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;

    ref.listen(changeLanguageProvider, (previous, next) {
      if (next.status.isSuccess && next.selectedLocale != null) {
        ref
            .read(localizationProvider.notifier)
            .selectLocale(locale: next.selectedLocale!);
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          context.showSnackBar(message: context.l10n.change_language);
        });
        context.pop();
      } else if (next.status.isError) {
        context.showSnackBar(
          message: l10n.sorry_we_have_problems_please_try_again_later,
          type: AppSnackbarType.negative,
        );
      }
    });
    final state = ref.watch(changeLanguageProvider);
    final selectedLocale =
        state.selectedLocale ?? Localizations.localeOf(context);

    return RadioGroup<Locale>(
      groupValue: selectedLocale,
      onChanged: (value) {
        if (value != null) {
          ref
              .read(changeLanguageProvider.notifier)
              .selectLanguage(locale: value);
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Radio(value: Locale('es')),
              Text(l10n.spanish),
            ],
          ),
          const Divider(),
          Row(
            children: [
              Radio(value: Locale('en')),
              Text(l10n.english),
            ],
          ),
          const Spacer(),
          LoadingButton(
            text: l10n.save,
            isLoading: state.status.isLoading,
            onTap: () => ref.read(changeLanguageProvider.notifier).save(),
          ),
        ],
      ),
    );
  }
}
