class StoryRemoteEntity {
  final String id;
  final String uid;
  final String title;
  final String filePath;
  final String createdAt;
  final int likes;
  final String challengeId;

  const StoryRemoteEntity({
    required this.id,
    required this.uid,
    required this.title,
    required this.filePath,
    required this.createdAt,
    required this.likes,
    required this.challengeId,
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': uid,
      'title': title,
      'file_path': filePath,
      'created_at': createdAt,
      'likes': likes,
      'challenge_id': challengeId,
    };
  }

  factory StoryRemoteEntity.fromJson({required Map<String, dynamic> json}) {
    return StoryRemoteEntity(
      id: json['id'] as String,
      uid: json['user_id'] as String,
      title: json['title'] as String,
      filePath: json['file_path'] as String,
      createdAt: json['created_at'] as String,
      likes: json['likes'] as int,
      challengeId: json['challenge_id'] as String,
    );
  }

  StoryRemoteEntity copyWith({
    String? id,
    String? uid,
    String? title,
    String? filePath,
    String? createdAt,
    int? likes,
    String? challengeId,
  }) {
    return StoryRemoteEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      title: title ?? this.title,
      filePath: filePath ?? this.filePath,
      createdAt: createdAt ?? this.createdAt,
      likes: likes ?? this.likes,
      challengeId: challengeId ?? this.challengeId,
    );
  }
}
