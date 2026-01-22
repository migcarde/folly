import 'package:flutter/widgets.dart';
import 'package:folly/features/reset_password/reset_password_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class ResetPasswordPage extends StatelessWidget {
  const ResetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: const ResetPasswordMobileLayout());
  }
}
