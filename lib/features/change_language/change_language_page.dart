import 'package:flutter/material.dart';
import 'package:folly/features/change_language/change_language_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class ChangeLanguagePage extends StatelessWidget {
  const ChangeLanguagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: ChangeLanguageMobileLayout());
  }
}
