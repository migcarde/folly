import 'package:data/remote/report_users/report_user_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/report_user/models/report_user_entity.dart';
import 'package:domain/report_user/report_user_repository.dart';
import 'package:logging_service/logging_service.dart';
import 'package:riverpod/riverpod.dart';

class ReportUserRepositoryImpl extends ReportUserRepository {
  final ReportUserRemoteDatasource _reportUserRemoteDatasource;
  final _log = LoggingService.getLogger('ReportUserRepositoryImpl');

  ReportUserRepositoryImpl(this._reportUserRemoteDatasource);

  @override
  Future<Result<void>> reportUser({
    required ReportUserEntity reportUser,
  }) async {
    try {
      await _reportUserRemoteDatasource.reportUser(
        reportUser: reportUser.remoteEntity,
      );

      return Result.success(null);
    } catch (e) {
      _log.severe(e);

      return Result.failure(e);
    }
  }
}

final reportUserRepositoryProvider = Provider.autoDispose<ReportUserRepository>(
  (ref) =>
      ReportUserRepositoryImpl(ref.watch(reportUserRemoteDatasourceProvider)),
);
