class LikeRemoteEntity {
  final String id;
  final String uid;
  final String storyId;

  const LikeRemoteEntity({
    required this.id,
    required this.uid,
    required this.storyId,
  });

  Map<String, dynamic> toJson() => {'uid': uid, 'story_id': storyId};

  factory LikeRemoteEntity.fromJson({required Map<String, dynamic> json}) =>
      LikeRemoteEntity(
        id: json['id'],
        uid: json['uid'],
        storyId: json['story_id'],
      );
}
