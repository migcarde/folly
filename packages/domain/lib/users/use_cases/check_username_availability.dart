import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/users/user_repository.dart';
import 'package:riverpod/riverpod.dart';

class CheckUsernameAvailability implements BaseUseCase<bool, String> {
  final UserRepository userRepository;

  CheckUsernameAvailability({required this.userRepository});

  @override
  Future<Result<bool>> call(String params) async =>
      userRepository.checkUsernameAvailability(username: params);
}

final checkUserAvailabilityProvider = Provider<CheckUsernameAvailability>(
  (ref) => CheckUsernameAvailability(
    userRepository: ref.watch(userRepositoryProvider),
  ),
);
