import 'package:flutter/widgets.dart';
import 'package:folly/features/home/reset_password_request/reset_password_request_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class ResetPasswordRequestPage extends StatelessWidget {
  const ResetPasswordRequestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: const ResetPasswordRequestMobileLayout());
  }
}
