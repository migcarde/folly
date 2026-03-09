class FeedRemoteEntity {
  final String id;
  final String createdAt;
  final bool isRead;
  final String userId;
  final String storyId;

  const FeedRemoteEntity({
    required this.id,
    required this.createdAt,
    required this.isRead,
    required this.userId,
    required this.storyId,
  });

  factory FeedRemoteEntity.fromJson({required Map<String, dynamic> json}) {
    return FeedRemoteEntity(
      id: json['id'],
      createdAt: json['created_at'],
      isRead: json['is_read'],
      userId: json['user_id'],
      storyId: json['story_id'],
    );
  }

  Map<String, dynamic> toJson() => {
    if (id != '') 'id': id,
    'is_read': isRead,
    'user_id': userId,
    'story_id': storyId,
  };
}
