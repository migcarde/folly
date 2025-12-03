import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/requests/models/request_entity.dart';
import 'package:domain/requests/request_repository_impl.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:riverpod/riverpod.dart';

abstract class RequestRepository {
  Future<Result<void>> sendRequest({
    required String senderId,
    required String receiverId,
  });
  Future<Result<void>> deleteRequest({required String id});
  Future<Result<List<RequestEntity>>> getRequests({required String uid});
  Future<Result<void>> acceptRequest({required RequestEntity request});
  Future<Result<void>> rejectRequest({required RequestEntity request});
  Future<Result<bool>> isPending({
    required UserEntity user,
    required String receiverId,
  });
}

final requestRepositoryProvider = Provider.autoDispose<RequestRepository>(
  (ref) => RequestRepositoryImpl(
    requestRemoteDatasource: ref.watch(requestRemoteDatasurceProvider),
    userRemoteDatasource: ref.watch(userRemoteDatasourceProvider),
  ),
);
