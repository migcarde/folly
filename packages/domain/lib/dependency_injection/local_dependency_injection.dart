import 'package:data/data.dart';
import 'package:data/remote/login/login_remote_datasource_impl.dart';
import 'package:data/remote/users/user_remote_datasource_impl.dart';
import 'package:riverpod/riverpod.dart';

final loginRemoteDatasourceProvider = Provider<LoginRemoteDatasource>((ref) {
  return LoginRemoteDatasourceImpl();
});

final userRemoteDatasourceProvider = Provider<UserRemoteDataSource>(
  (ref) => UserRemoteDatasourceImpl(),
);
