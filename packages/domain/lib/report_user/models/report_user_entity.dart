import 'dart:io';

import 'package:data/remote/report_users/models/report_user_remote_entity.dart';

class ReportUserEntity {
  final String description;
  final File file;
  final String senderUserId;
  final String reportedUserId;

  const ReportUserEntity({
    required this.description,
    required this.file,
    required this.senderUserId,
    required this.reportedUserId,
  });

  ReportUserRemoteEntity get remoteEntity => ReportUserRemoteEntity(
    description: description,
    file: file,
    senderUserId: senderUserId,
    reportedUserId: reportedUserId,
  );
}
