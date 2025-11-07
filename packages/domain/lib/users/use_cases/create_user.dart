import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/models/create_user_entity.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';
import 'package:riverpod/riverpod.dart';

class CreateUser implements BaseUseCase<UserEntity, CreateUserEntity> {
  final UserRepository userRepository;

  CreateUser({required this.userRepository});

  @override
  Future<Result<UserEntity>> call(CreateUserEntity params) async =>
      userRepository.createUser(user: params);
}

final createUserProvider = Provider<CreateUser>(
  (ref) => CreateUser(userRepository: ref.watch(userRepositoryProvider)),
);
