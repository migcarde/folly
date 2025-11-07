import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/models/user_entity.dart';
import 'package:domain/users/user_repository.dart';

class SaveUser implements BaseUseCase<void, UserEntity> {
  final UserRepository userRepository;

  SaveUser({required this.userRepository});

  @override
  Future<Result<void>> call(UserEntity params) =>
      userRepository.saveUser(user: params);
}
