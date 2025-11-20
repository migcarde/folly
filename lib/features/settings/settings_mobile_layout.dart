import 'package:flutter/material.dart';
import 'package:folly/extensions/build_context_extensions.dart';
import 'package:folly/features/settings/widgets/settings_tile.dart';
import 'package:folly/routes/paths.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SettingsMobileLayout extends StatelessWidget {
  const SettingsMobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

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
          onTap: () {},
        ),
      ],
    );
  }
}
