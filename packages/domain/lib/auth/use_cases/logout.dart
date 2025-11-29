import 'package:domain/base/base_use_case.dart';
import 'package:domain/base/result.dart';
import 'package:domain/auth/auth_repository.dart';
import 'package:riverpod/riverpod.dart';

class Logout extends BaseUseCase<void, void> {
  final AuthRepository loginRepository;

  Logout({required this.loginRepository});

  @override
  Future<Result<void>> call(void params) async =>
      await loginRepository.logout();
}

final logoutProvider = Provider.autoDispose<Logout>(
  (ref) => Logout(loginRepository: ref.watch(authRepositoryProvider)),
);
