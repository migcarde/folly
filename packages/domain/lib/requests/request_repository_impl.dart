import 'package:data/data.dart';
import 'package:domain/base/result.dart';
import 'package:domain/requests/models/request_entity.dart';
import 'package:domain/requests/request_repository.dart';
import 'package:domain/users/models/user_entity.dart';

class RequestRepositoryImpl implements RequestRepository {
  final RequestRemoteDatasource requestRemoteDatasource;
  final UserRemoteDataSource userRemoteDatasource;

  const RequestRepositoryImpl({
    required this.requestRemoteDatasource,
    required this.userRemoteDatasource,
  });

  @override
  Future<Result<void>> acceptRequest({required RequestEntity request}) async {
    try {
      final updatedReceiver = request.receiver.addFriend(request.user.uid);
      final updatedUser = request.user.addFriend(request.receiver.uid);

      await Future.wait([
        userRemoteDatasource.saveUser(user: updatedReceiver.remoteEntity),
        userRemoteDatasource.saveUser(user: updatedUser.remoteEntity),
      ]);

      await requestRemoteDatasource.deleteRequest(id: request.id);
      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> deleteRequest({required String id}) async {
    try {
      await requestRemoteDatasource.deleteRequest(id: id);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<List<RequestEntity>>> getRequests({required String uid}) async {
    try {
      List<RequestEntity> users = [];
      final result = await requestRemoteDatasource.getPendingRequests(uid: uid);

      for (final request in result) {
        final requestEntity = await _getRequestEntity(request);

        users.add(requestEntity);
      }

      return Result.success(users);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> rejectRequest({required RequestEntity request}) async {
    try {
      await requestRemoteDatasource.deleteRequest(id: request.id);

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> sendRequest({
    required String senderId,
    required String receiverId,
  }) async {
    try {
      await requestRemoteDatasource.sendRequest(
        senderId: senderId,
        receiverId: receiverId,
      );

      return Result.success(null);
    } catch (e) {
      return Result.failure(e);
    }
  }

  Future<RequestEntity> _getRequestEntity(RequestRemoteEntity request) async {
    final requestUsers = await Future.wait([
      userRemoteDatasource.getUser(uid: request.uid),
      userRemoteDatasource.getUser(uid: request.receiverUid),
    ]);

    return RequestEntity(
      id: request.id,
      user: requestUsers[0].entity,
      receiver: requestUsers[1].entity,
    );
  }

  @override
  Future<Result<bool>> isPending({
    required UserEntity user,
    required String receiverId,
  }) async {
    try {
      final result = await requestRemoteDatasource.getPendingRequests(
        uid: user.uid,
      );

      final isPending = result.any(
        (request) => request.receiverUid == receiverId,
      );

      return Result.success(isPending);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
