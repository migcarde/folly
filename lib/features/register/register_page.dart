import 'package:flutter/material.dart';
import 'package:folly/features/register/register_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: RegisterMobileLayout());
  }
}
