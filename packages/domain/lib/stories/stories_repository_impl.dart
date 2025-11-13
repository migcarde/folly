import 'dart:io';

import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:domain/base/result.dart';
import 'package:domain/stories/stories_repository.dart';

class StoriesRepositoryImpl implements StoriesRepository {
  final StoriesRemoteDatasource storiesRemoteDatasource;

  const StoriesRepositoryImpl({required this.storiesRemoteDatasource});

  @override
  Future<Result<void>> init() async {
    try {
      final result = await storiesRemoteDatasource.init();

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }

  @override
  Future<Result<void>> uploadFile({required File file}) async {
    try {
      final result = await storiesRemoteDatasource.uploadStory(file: file);

      return Result.success(result);
    } catch (e) {
      return Result.failure(e);
    }
  }
}
