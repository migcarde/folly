import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:data/remote/stories/stories_remote_datasource.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class StoriesRemoteDatasourceImpl extends StoriesRemoteDatasource {
  late SupabaseClient _supabase;

  static const _bucket = 'media';
  static const _supabaseCollections = 'supabase';

  final FirebaseFirestore _instance = FirebaseFirestore.instance;

  @override
  Future<void> uploadStory({required File file}) async {
    final fileBytes = await file.readAsBytes();

    await _supabase.storage.from(_bucket).uploadBinary(file.path, fileBytes);
  }

  @override
  Future<void> init() async {
    final result = await _instance
        .collection(_supabaseCollections)
        .doc('keys')
        .get();

    final data = result.data()!;

    await Supabase.initialize(url: data['url'], anonKey: data['anonKey']);

    _supabase = Supabase.instance.client;
  }
}
