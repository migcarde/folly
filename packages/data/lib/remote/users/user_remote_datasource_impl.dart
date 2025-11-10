import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/remote/users/models/user_remote_entity.dart';
import 'package:data/remote/users/user_remote_datasource.dart';

class UserRemoteDatasourceImpl extends UserRemoteDataSource {
  static const _usersCollection = 'users';
  static const _usernameCollection = 'usernames';
  static const _geminiCollection = 'gemini';

  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<void> saveUser({required UserRemoteEntity user}) async {
    await Future.wait([
      _instance.collection(_usernameCollection).doc(user.uid).set({
        'username': user.username,
      }),
      _instance.collection(_usersCollection).add(user.toJson()),
    ]);
  }

  @override
  Future<void> deleteUser({required String uid}) async {
    await Future.wait([
      _instance.collection(_usernameCollection).doc(uid).delete(),
      _instance.collection(_usersCollection).doc(uid).delete(),
    ]);
  }

  @override
  Future<UserRemoteEntity> getUser({required String uid}) async {
    final result = await _instance.collection(_usersCollection).doc(uid).get();

    return UserRemoteEntity.fromJson(uid: uid, json: result.data()!);
  }

  @override
  Future<bool> checkUsernameAvailability({required String username}) async {
    final result = await _instance
        .collection(_usernameCollection)
        .where('username', isEqualTo: username)
        .limit(1)
        .get();

    return result.docs.isEmpty;
  }

  @override
  Future<String> getAIToken() async {
    final result = await _instance
        .collection(_geminiCollection)
        .doc('key')
        .get();

    return result.data()?['value'] ?? '';
  }
}
