import 'package:domain/base/result.dart';
import 'package:domain/report_user/models/report_user_entity.dart';

abstract class ReportUserRepository {
  Future<Result<void>> reportUser({required ReportUserEntity reportUser});
}
