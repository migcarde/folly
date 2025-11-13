import 'dart:io';

import 'package:domain/base/result.dart';
import 'package:domain/dependency_injection/local_dependency_injection.dart';
import 'package:domain/stories/stories_repository_impl.dart';
import 'package:riverpod/riverpod.dart';

abstract class StoriesRepository {
  Future<Result<void>> init();
  Future<Result<void>> uploadFile({required File file});
}

final storiesRepositoryProvider = Provider.autoDispose<StoriesRepository>(
  (ref) => StoriesRepositoryImpl(
    storiesRemoteDatasource: ref.watch(storiesRemoteDatasourceProvider),
  ),
);
