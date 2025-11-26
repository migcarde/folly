import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:folly/core/app_dimens.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/auth_notifier.dart';
import 'package:folly/features/settings/widgets/settings_tile.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsMobileLayout extends ConsumerWidget {
  const SettingsMobileLayout({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final theme = context.theme;

    return Column(
      children: [
        SettingsTile(
          icon: PhosphorIcons.userGear(),
          text: l10n.user_settings,
          onTap: () => context.push(Paths.editProfile.route),
        ),
        const Divider(),
        SettingsTile(
          icon: PhosphorIcons.translate(),
          text: l10n.change_language,
          onTap: () => context.push(Paths.changeLanguage.route),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => ref.read(authNotifierProvider.notifier).logout(),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(PhosphorIcons.signOut(), color: theme.colorScheme.error),
              Padding(
                padding: const EdgeInsets.only(left: AppDimens.s),
                child: Text(
                  l10n.logout,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.error,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
