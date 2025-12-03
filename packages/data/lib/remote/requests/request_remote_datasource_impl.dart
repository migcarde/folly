import 'package:data/remote/requests/models/request_remote_entity.dart';
import 'package:data/remote/requests/request_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RequestRemoteDatasourceImpl implements RequestRemoteDatasource {
  static const _requestsCollections = 'Requests';

  final Supabase _instance = Supabase.instance;

  @override
  Future<void> deleteRequest({required String id}) async =>
      await _instance.client.from(_requestsCollections).delete().eq('id', id);

  @override
  Future<void> sendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    final requestRemoteEntity = RequestRemoteEntity(
      id: '',
      uid: senderId,
      receiverUid: receiverId,
    );

    await _instance.client
        .from(_requestsCollections)
        .insert(requestRemoteEntity.toJson());
  }

  @override
  Future<List<RequestRemoteEntity>> getRequests({required String uid}) async {
    final result = await _instance.client
        .from(_requestsCollections)
        .select()
        .eq('receiver_uid', uid);

    return result
        .map((json) => RequestRemoteEntity.fromJson(json: json))
        .toList();
  }

  @override
  Future<List<RequestRemoteEntity>> getPendingRequests({
    required String uid,
  }) async {
    final result = await _instance.client
        .from(_requestsCollections)
        .select()
        .eq('uid', uid);

    return result
        .map((json) => RequestRemoteEntity.fromJson(json: json))
        .toList();
  }
}
