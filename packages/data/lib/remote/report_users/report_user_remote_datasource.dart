import 'package:data/remote/report_users/models/report_user_remote_entity.dart';

abstract class ReportUserRemoteDatasource {
  Future<void> reportUser({required ReportUserRemoteEntity reportUser});
}
