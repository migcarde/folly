import 'package:flutter/widgets.dart';
import 'package:folly/features/report_user/report_user_mobile_layout.dart';
import 'package:folly/widgets/base_scaffold.dart';

class ReportUserPage extends StatelessWidget {
  const ReportUserPage({super.key, required this.uid});

  final String uid;

  @override
  Widget build(BuildContext context) {
    return BaseScaffold(child: ReportUserMobileLayout(uid: uid));
  }
}
