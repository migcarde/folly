import 'package:flutter/material.dart';
import 'package:folly/features/settings/settings_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: SettingsMobileLayout());
  }
}
