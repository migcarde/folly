import 'package:data/remote/requests/models/request_remote_entity.dart';

abstract class RequestRemoteDatasource {
  Future<void> sendRequest({
    required String senderId,
    required String receiverId,
  });
  Future<void> deleteRequest({required String id});
  Future<List<RequestRemoteEntity>> getRequests({required String uid});
  Future<List<RequestRemoteEntity>> getPendingRequests({required String uid});
}
