import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:riverpod/riverpod.dart';

class GetUser implements BaseUseCase<UserEntity, String> {
  const GetUser({required this.userRepository});

  final UserRepository userRepository;

  @override
  Future<Result<UserEntity>> call(String params) async =>
      userRepository.getUser(uid: params);
}

final getUserProvider = Provider.autoDispose<GetUser>(
  (ref) => GetUser(userRepository: ref.watch(userRepositoryProvider)),
);
