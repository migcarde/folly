import 'dart:io';

import 'package:data/remote/stories/models/story_remote_entity.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoriesRemoteDatasourceImpl extends StoriesRemoteDatasource {
  final Supabase _supabase = Supabase.instance;

  static const _bucket = 'media';
  static const _storiesCollection = 'Stories';

  @override
  Future<void> uploadStory({
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

    await _supabase.client.from(_storiesCollection).insert(story.toJson());
  }

  @override
  Future<List<StoryRemoteEntity>> getStories({
    required List<String> uids,
  }) async {
    final results = await _supabase.client
        .from(_storiesCollection)
        .select()
        .inFilter('user_id', uids)
        .order('created_at', ascending: false);

    final stories = results.map((json) {
      final story = StoryRemoteEntity.fromJson(json: json);
      final imageUrl = _supabase.client.storage
          .from(_bucket)
          .getPublicUrl(story.filePath);

      return story.copyWith(filePath: imageUrl);
    }).toList();

    // TODO: Set as paginated

    return stories;
  }

  @override
  Future<List<StoryRemoteEntity>> getStoriesFromUser({
    required String uid,
  }) async {
    final results = await _supabase.client
        .from(_storiesCollection)
        .select()
        .eq('user_id', uid)
        .order('created_at', ascending: false);

    final stories = results.map((json) {
      final story = StoryRemoteEntity.fromJson(json: json);
      final imageUrl = _supabase.client.storage
          .from(_bucket)
          .getPublicUrl(story.filePath);

      return story.copyWith(filePath: imageUrl);
    }).toList();

    // TODO: Set as paginated

    return stories;
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
