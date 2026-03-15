import 'dart:io';

class ReportUserRemoteEntity {
  final String description;
  final File file;
  final String senderUserId;
  final String reportedUserId;

  const ReportUserRemoteEntity({
    required this.description,
    required this.file,
    required this.senderUserId,
    required this.reportedUserId,
  });

  Map<String, dynamic> toJson({required String path}) => {
    'description': description,
    'media': path,
    'sender_user_id': senderUserId,
    'reported_user_id': reportedUserId,
  };
}
