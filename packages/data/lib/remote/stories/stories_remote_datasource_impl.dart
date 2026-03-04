import 'dart:io';

import 'package:data/remote/models/page_remote_entity.dart';
import 'package:data/remote/stories/models/story_remote_entity.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoriesRemoteDatasourceImpl extends StoriesRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  static const _bucket = 'media';
  static const _storiesCollection = 'Stories';

  @override
  Future<StoryRemoteEntity> uploadStory({
    required String uid,
    required String title,
    required File file,
    required String challengeId,
  }) async {
    final fileBytes = await file.readAsBytes();

    final path =
        '$uid/${DateTime.now().toIso8601String()}-${file.path.split('/').last}';
    await _supabase.client.storage.from(_bucket).uploadBinary(path, fileBytes);

    final story = StoryRemoteEntity(
      id: '',
      uid: uid,
      title: title,
      filePath: path,
      createdAt: DateTime.now().toIso8601String(),
      likes: 0,
      challengeId: challengeId,
    );

    final result = await _supabase.client
        .from(_storiesCollection)
        .insert(story.toJson())
        .select()
        .single();

    return StoryRemoteEntity.fromJson(json: result);
  }

  @override
  Future<PageRemoteEntity<StoryRemoteEntity>> getStories({
    required List<String> uids,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _supabase.client
        .from(_storiesCollection)
        .select()
        .inFilter('user_id', uids)
        .range(startIndex, endIndex)
        .order('created_at', ascending: false)
        .count(CountOption.exact);

    final stories = result.data.map((json) {
      final story = StoryRemoteEntity.fromJson(json: json);
      final imageUrl = _supabase.client.storage
          .from(_bucket)
          .getPublicUrl(story.filePath);

      return story.copyWith(filePath: imageUrl);
    }).toList();

    return PageRemoteEntity(
      content: stories,
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<PageRemoteEntity<StoryRemoteEntity>> getStoriesFromUser({
    required String uid,
    required int page,
    int size = 10,
    int? total,
  }) async {
    final (startIndex, endIndex) = PageRemoteEntity.getIndexes(
      page: page,
      size: size,
      total: total,
    );

    final result = await _supabase.client
        .from(_storiesCollection)
        .select()
        .eq('user_id', uid)
        .range(startIndex, endIndex)
        .order('created_at', ascending: false)
        .count(CountOption.exact);

    final stories = result.data.map((json) {
      final story = StoryRemoteEntity.fromJson(json: json);
      final imageUrl = _supabase.client.storage
          .from(_bucket)
          .getPublicUrl(story.filePath);

      return story.copyWith(filePath: imageUrl);
    }).toList();

    return PageRemoteEntity(
      content: stories,
      page: page,
      totalPages: (result.count / size).ceil(),
      total: result.count,
    );
  }

  @override
  Future<StoryRemoteEntity> getStory({required String storyId}) async {
    final json = await _supabase.client
        .from(_storiesCollection)
        .select()
        .eq('id', storyId)
        .single();

    final result = StoryRemoteEntity.fromJson(json: json);
    final imageUrl = _supabase.client.storage
        .from(_bucket)
        .getPublicUrl(result.filePath);

    return result.copyWith(filePath: imageUrl);
  }

  @override
  Future<StoryRemoteEntity> updateStory({
    required StoryRemoteEntity story,
  }) async {
    final result = await _supabase.client
        .from(_storiesCollection)
        .update(story.toJson())
        .eq('id', story.id)
        .select()
        .single();

    return StoryRemoteEntity.fromJson(json: result);
  }
}
