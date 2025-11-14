import 'package:data/data.dart';
import 'package:data/remote/challenges/challenges_remote_datasource.dart';
import 'package:data/remote/challenges/challenges_remote_datasource_impl.dart';
import 'package:data/remote/users/user_remote_datasource_impl.dart';
import 'package:riverpod/riverpod.dart';

final authRemoteDatasourceProvider = Provider<AuthRemoteDatasource>((ref) {
  return AuthRemoteDatasourceImpl();
});

final userRemoteDatasourceProvider = Provider<UserRemoteDataSource>(
  (ref) => UserRemoteDatasourceImpl(),
);

final challengeRemoteDatasourceProvider =
    Provider.autoDispose<ChallengesRemoteDatasource>(
      (ref) => ChallengesRemoteDatasourceImpl(),
    );
