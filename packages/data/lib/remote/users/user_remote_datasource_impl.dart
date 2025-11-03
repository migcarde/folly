import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:data/remote/users/user_remote_datasource.dart';

class UserRemoteDatasourceImpl extends UserRemoteDataSource {
  static const _collection = 'users';

  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<void> saveUser({required UserRemoteEntity user}) async =>
      await _instance.collection(_collection).doc(user.uid).set(user.toJson());

  @override
  Future<void> deleteUser({required String uid}) async =>
      await _instance.collection(_collection).doc(uid).delete();

  @override
  Future<UserRemoteEntity> getUser({required String uid}) async {
    final result = await _instance.collection(_collection).doc(uid).get();

    return UserRemoteEntity.fromJson(uid: uid, json: result.data()!);
  }
}
