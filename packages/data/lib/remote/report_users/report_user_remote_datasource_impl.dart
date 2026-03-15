import 'package:data/remote/report_users/models/report_user_remote_entity.dart';
import 'package:data/remote/report_users/report_user_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ReportUserRemoteDatasourceImpl extends ReportUserRemoteDatasource {
  final Supabase _instance = Supabase.instance;

  static const _reportsCollection = 'Reports';
  static const _bucket = 'reports';

  @override
  Future<void> reportUser({required ReportUserRemoteEntity reportUser}) async {
    final fileBytes = await reportUser.file.readAsBytes();

    final path =
        '${reportUser.senderUserId}/${DateTime.now().toIso8601String()}-${reportUser.file.path.split('/').last}';
    await _instance.client.storage.from(_bucket).uploadBinary(path, fileBytes);

    await _instance.client
        .from(_reportsCollection)
        .insert(reportUser.toJson(path: path));
  }
}
