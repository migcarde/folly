import 'package:flutter/material.dart';
import 'package:folly/features/login/login_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: LoginMobileLayout());
  }
}
