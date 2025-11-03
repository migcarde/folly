import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/user_repository.dart';

class DeleteUser implements BaseUseCase<void, String> {
  final UserRepository userRepository;

  DeleteUser({required this.userRepository});

  @override
  Future<Result<void>> call(String params) async =>
      userRepository.deleteUser(uid: params);
}
